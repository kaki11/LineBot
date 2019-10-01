class TopicsController < ApplicationController

  def index
  end

  def new
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topics_path, success: '登録しました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:send_message, :receive_message)
  end

end
