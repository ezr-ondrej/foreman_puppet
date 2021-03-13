require 'test_puppet_helper'
require 'unit/test/puppet_fact_parser_test'

module ForemanPuppetEnc
  class PuppetFactsParserTest < ::PuppetFactsParserTest
    # Just retest we are not breaking anything

    test "should return an env" do
      assert_kind_of ForemanPuppet::Environment, importer.environment
    end
  end
end
