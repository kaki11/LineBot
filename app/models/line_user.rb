class LineUser < ApplicationRecord
  validates :line_id, presence: true
  belongs_to :user

  def self.get_token(params)
    uri = URI.parse('https://api.line.me/oauth2/v2.1/token')
    res = Net::HTTP.post_form(uri, { 
      client_id: ENV["LINE_CLIENT_ID"],
      client_secret: ENV["LINE_CLIENT_SECRET"],
      code: params[:code],
      grant_type: "authorization_code",
      redirect_uri: ENV["RIDIRECT_URI"]
    })
    result = JSON.parse(res.body)
    token = result["access_token"]

  end

  def self.user_info(token)
    uri2 = URI.parse("https://api.line.me/v2/profile")
    http = Net::HTTP.new(uri2.host, uri2.port)
    http.use_ssl = uri2.scheme === "https"
    headers = { Authorization: "Bearer #{token}" }
    response = http.get(uri2.path, headers)

    user = JSON.parse(response.body)
    user_line_id = user["userId"]
    # user_line_name = user["displayName"]

  end
  
end
