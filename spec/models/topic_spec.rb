require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { build(:topic) }
  let(:line_user) { build(:line_user) }

  context "登録が成功する場合" do
    it "送信、受信メッセージがあれば登録できる" do
      expect(topic).to be_valid
    end
    it "149文字以下なら登録できる" do
      user = FactoryBot.create(:user)
    topic = user.topics.build(send_message: "a"*149, receive_message: "a"*149)
    expect(topic).to be_valid
    end
  end

  context "登録が失敗する場合" do
    it "送信メッセージがなければ登録できない" do
    end
    it "受信メッセージがなければ登録できない" do
    end
    it "150文字以上だと登録できない" do
    end
  end




  it "送信、受信メッセージがあれば登録できる" do
    expect(FactoryBot.create(:topic)).to be_valid
  end

  it "送信メッセージがなければ登録できない" do
    expect(FactoryBot.build(:topic, send_message: "")).to_not be_valid
  end

  it "受信メッセージがなければ登録できない" do
    expect(FactoryBot.build(:topic, receive_message: "")).to_not be_valid
  end

  it "150文字以上登録できない" do
    topic = FactoryBot.build(:topic, send_message: "a"*150)
    expect(topic).to_not be_valid
    expect(topic.send_message.length).to be >= 150
  end

  it "149文字だと登録できる" do
    user = FactoryBot.create(:user)
    topic = user.topics.build(send_message: "a"*149, receive_message: "a"*149)
    expect(topic).to be_valid
  end

end
