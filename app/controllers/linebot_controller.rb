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
      userId = event['source']['userId'] #userId取得

      case event
        # メッセージが送信された場合の対応
      when Line::Bot::Event::Message
        case event.type
          # テキスト形式のメッセージが送られて来た時
        when Line::Bot::Event::MessageType::Text
            # event.message['text']: ユーザーが入力したメッセージ
          input = event.message['text']
          
          if input == "登録"
            push = "ログインしてね〜\n" + "https://line-botkun.herokuapp.com/"
          elsif input == "a"
            push = userId
          elsif input == ""
            push = ""
          else
            push = input + "??\n"
            
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
