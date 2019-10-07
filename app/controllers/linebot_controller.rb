class LinebotController < ApplicationController
  require 'line/bot'

  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)
    
    events.each { |event|
      #userId取得
    userId = event['source']['userId']
      case event
        # メッセージが送信された場合の対応
      when Line::Bot::Event::Message
        case event.type
          # テキスト形式のメッセージが送られて来た時
        when Line::Bot::Event::MessageType::Text
            # event.message['text']: ユーザーが入力したメッセージ
          input = event.message['text']
          user = LineUser.find_by(line_id: userId)
          topics = user.user.topics
          #送られてきたメッセージをユーザーtopicsから検索
          topic = topics.find_by(send_message: input)
          
          if user.nil?
            push = "まだ連携が終わってないみたい＞＜\nログインして連携させてね！\nhttp://localhost:3000"

          elsif input == "とうろく"
            push = "http://localhost:3000" 
    
          elsif topic.nil?
            push = input + "？\n『とうろく』で登録画面に飛べるよ！"
          
          elsif input == topic.send_message
            receive_message = topics.find_by(send_message: input).receive_message
            push = receive_message

          else
            push = "もう一度入力してね！"
          end
        end

          #送信するメッセージを定義
        message = {
          type: 'text',
          text: push
        }
        client.reply_message(event['replyToken'], message)
      end
    }
    head :ok
  end

  private
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
  end
end
