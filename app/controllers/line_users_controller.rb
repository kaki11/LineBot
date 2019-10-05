class LineUsersController < ApplicationController
  
  def index
    #アクセストークンの取得
    uri = URI.parse('https://api.line.me/oauth2/v2.1/token')
    res = Net::HTTP.post_form(uri, { 
      client_id: "1626757935",
      client_secret: "03e565abb28e0fbbd5fe695eb1d2cca0",
      code: params[:code],
      grant_type: "authorization_code",
      redirect_uri: "http://localhost:3000/show"
    })
    result = JSON.parse(res.body)
    token = result["access_token"]

    #ユーザー情報の取得
    uri2 = URI.parse("https://api.line.me/v2/profile")
    http = Net::HTTP.new(uri2.host, uri2.port)
    http.use_ssl = uri2.scheme === "https"
    headers = { Authorization: "Bearer #{token}" }
    response = http.get(uri2.path, headers)

    #ユーザーとline_uidを紐ずける
    user_info = JSON.parse(response.body)
    user_line_id = user_info["userId"]
    user_line_name = user_info["displayName"]
    puts user_line_id
    puts user_line_name

  end

  def create
    
  end

  private
    def line_params
      params.require(:line_user).permit(:line_id)
    end

end
