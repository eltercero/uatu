require 'sinatra/base'

class FakeMarvelApi < Sinatra::Base
  get '/v1/public/:resources' do
    json_response 200, "#{params['resources']}/list.json"
  end

  get '/v1/public/:resources/:id/:nested_resources' do
    json_response 200, "#{params['nested_resources']}/list.json"
  end

  get '/v1/public/:resources/:id' do
    json_response 200, "#{params['resources']}/show.json"
  end

private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fake_marvel_api/' + file_name, 'rb').read
  end

end