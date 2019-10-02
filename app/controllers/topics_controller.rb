class TopicsController < ApplicationController
  before_action :set_topic_id, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :destroy]

  def index
    @topics = Topic.all
  end
  
  def show
    @topic = Topic.find_by(id: params[:id])
    @user = User.find_by(id: @topic.user_id)
  end
  
  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def destroy
    if @topic.user_id == current_user.id
      @topic.destroy
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = "削除出来ません"
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:send_message, :receive_message)
  end

  def set_topic_id
    @topic = Topic.find(params[:id])
  end

end
