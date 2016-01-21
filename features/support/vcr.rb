require 'vcr'
require 'webmock/cucumber'

VCR.configure do |c|
  c.default_cassette_options = { :record => :once }
  c.cassette_library_dir = 'features/support/vcr'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = false

  [
    'GITHUB_CLIENT_ID',
    'GITHUB_CLIENT_SECRET'
  ].each do |env_var|
    c.filter_sensitive_data("<#{env_var}>") { ENV[env_var] }
  end
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
end
