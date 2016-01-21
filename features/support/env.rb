ENV['RACK_ENV'] = 'test'
require 'coveralls'
Coveralls.wear!

require File.join(File.dirname(__FILE__), '..', '..', 'lib/funkdata.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'cucumber/api_steps'
require 'active_support/core_ext/object/blank'

Capybara.app = Funkdata

class FunkdataWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers

  def app
    Funkdata::App
  end
end

World do
  FunkdataWorld.new
end
