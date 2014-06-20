class FbShareController < ApplicationController
 
 
  def auth
 
     cookies["title"] = { :value => "test", :expires => 1.minute.from_now }
     cookies["url"] = { :value => "http://www.zipifieds.com", :expires => 1.minute.from_now }
     cookies["desc"] = { :value => "testrt", :expires => 1.minute.from_now }
 
    
 
  @client = client
 
    redirect_to @client.authorization_uri(
      :scope => [ :offline_access , :publish_stream]
    )
 
  end
 
 
  def callback
 
    @client = client
    @client.authorization_code = params[:code]
 
    access_token = @client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
 
    me = FbGraph::User.me(access_token)
 
    title = cookies["title"]
    url = cookies["url"]
    desc  = cookies["desc"]
 
    me.feed!(
 
        :message =>  title ,
        #:picture => / Your Image path / ,
        :link => url,
        :name => title,
        :description => desc
    )
 
    redirect_to root_path ( You Application Action path After sharing the content to FB)
 
  end
 
 
  private
 
 
  def client
 
    key = "457594381010252"
    secret = "9c322f063fd6071810e3e95cc9044d18"
    fb_auth = FbGraph::Auth.new(key, secret)
    client = fb_auth.client
    client.redirect_uri = "http://#{request.host_with_port}/fb_share/callback"
 
    client
 
  end
 
end