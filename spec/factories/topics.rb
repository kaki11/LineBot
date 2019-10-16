FactoryBot.define do
  factory :topic do
    send_message { "めっせーじ" }
    receive_message { "メッセージ" }
    user
  end
end
