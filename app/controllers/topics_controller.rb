class TopicsController < ApplicationController
  before_action :set_topic_id, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :destroy]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topics_path
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def destroy
    # @topic = topics.find_by(id: params[:id])
    @topic.destroy
      redirect_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:send_message, :receive_message)
  end

  def set_topic_id
    @topic = Topic.find(params[:id])
  end

end
