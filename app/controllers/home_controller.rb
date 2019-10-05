class HomeController < ApplicationController
  def index
  end

  def show
    uri = URI.parse('https://api.line.me/oauth2/v2.1/token')
    res = Net::HTTP.post_form(uri, { 
      client_id: "1626757935",
      client_secret: "03e565abb28e0fbbd5fe695eb1d2cca0",
      code: params[:code],
      grant_type: "authorization_code",
      redirect_uri: "http://localhost:3000/show"
    })
    puts res.body
  end

  def create
  end

end
