require 'sinatra'
require 'omniauth-bikeroar'
require 'json'
require 'pry'

class Demo < Sinatra::Base
  use Rack::Session::Cookie, :secret => 'change_me'
  use OmniAuth::Strategies::Bikeroar, '149b028761f2ec552e23dad006964204766e427424119e5293fc1ea0fb763240', '7802086eabd98521314118202f1a2bffaaeae3339d82afcb370992317299ec94',
    :callback_path => "/auth/bikeroar/callback",
    setup:  Proc.new { |env|
      client_options = env['omniauth.strategy'].options['client_options']
      client_options['site']          = 'http://localhost:3000'
      client_options['authorize_url'] = 'http://localhost:3000/oauth/authorize'
      client_options['token_url']     = 'http://localhost:3000/oauth/token'
    }

  get '/' do
    <<-HTML
    <a href='/auth/bikeroar'>Sign in with Bikeroar</a>
    HTML
  end

  post '/auth/:name/callback' do
    auth = request.env['omniauth.auth']
  end

  get '/auth/bikeroar/callback' do
    content_type :json
    request.env['omniauth.auth'].to_json
  end
end

Demo.run!
