class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to root_path, success: '編集しました'
    else
      render :edit
    end

  end


  private

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  # beforeアクション

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

end

