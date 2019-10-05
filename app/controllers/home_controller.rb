class HomeController < ApplicationController
  def index
  end

  def show
  #アクセストークンの取得
    uri = URI.parse('https://api.line.me/oauth2/v2.1/token')
    res = Net::HTTP.post_form(uri, { 
      client_id: "1626757935",
      client_secret: "03e565abb28e0fbbd5fe695eb1d2cca0",
      code: params[:code],
      grant_type: "authorization_code",
      redirect_uri: "http://localhost:3000/show"
    })
    puts res.body
    
    #ユーザー情報の取得
      uri = URI.parse("https://api.line.me/v2/profile")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme === "https"
      headers = { Authorization: "Bearer access_token" }
      response = http.get(uri.path, headers)
      puts response.code 
      puts response.body 

  end

  def create
  end

end
