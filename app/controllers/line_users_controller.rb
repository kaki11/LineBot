class LineUsersController < ApplicationController

  def index
     #アクセストークンの取得
    token = LineUser.get_token(params)
    #ユーザー情報の取得
    user_line_id = LineUser.user_info(token)
    
    #ユーザーとline_uidを紐ずける
    if LineUser.find_by(line_id: user_line_id).nil?
      LineUser.create!(user_id: current_user.id, line_id: user_line_id)
    else
      redirect_to user_path(current_user), info: 'もう連携済みだよ！登録している別のアカウントがあるかも！'
    end
  end

end
