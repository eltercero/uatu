require 'sinatra/base'

class FakeMarvelApi < Sinatra::Base
  # Account
  get '/api/v2/account/me' do
    json_response 200, 'account_me_ok_response.json'
  end

  # Line Items
  get '/api/v2/sections/:id/line_items' do
    json_response 200, 'line_items_nested_index_ok_response.json'
  end

  post '/api/v2/sections/:id/line_items' do
    json_response 201, "line_items_nested_create_ok_response.json"
  end

  # Proposals
  put '/api/v2/proposals/:id/send_proposal' do
    json_response 201, "proposals_send_proposal_ok_response.json"
  end

  # Common
  get '/api/v2/:resource/:id' do
    json_response 200, "#{params['resource']}_show_ok_response.json"
  end

  get '/api/v2/:resource' do
    json_response 200, "#{params['resource']}_index_ok_response.json"
  end

  post '/api/v2/:resource' do
    json_response 201, "#{params['resource']}_create_ok_response.json"
  end

  put '/api/v2/:resource/:id' do
    json_response 200, "#{params['resource']}_update_ok_response.json"
  end

  delete '/api/v2/:resource/:id' do
    json_response 200, "#{params['resource']}_delete_ok_response.json"
  end

private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fake_nusii/' + file_name, 'rb').read
  end

end