ForemanPuppetEnc::Engine.routes.draw do
  get 'foreman_puppet_enc', to: 'foreman_puppet_enc/react#index'
  resources :config_groups, except: [:show] do
    collection do
      get 'help', action: :welcome
      get 'auto_complete_search'
    end
  end

  get 'puppetclass_lookup_keys/help', :action => :welcome, :controller => 'puppetclass_lookup_keys'

  constraints(:id => /[^\/]+/) do
    resources :puppetclass_lookup_keys, :except => [:show, :new, :create] do
      resources :lookup_values, :only => [:index, :create, :update, :destroy]
      collection do
        get 'auto_complete_search'
      end
    end
  end

  namespace :api, defaults: { format: 'json' } do
    scope '(:apiv)', module: :v2, defaults: { apiv: 'v2' }, apiv: /v1|v2/, constraints: ApiConstraints.new(version: 2, default: true) do
      constraints(:id => /[^\/]+/) do
        resources :smart_class_parameters, :except => [:new, :edit, :create, :destroy] do
          resources :override_values, :except => [:new, :edit]
        end
      end
    end
  end
end

Foreman::Application.routes.draw do
  mount ForemanPuppetEnc::Engine, at: '/foreman_puppet_enc'
end
