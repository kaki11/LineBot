require 'rails_helper'

RSpec.describe Topic, type: :model do

  context "登録が成功する場合" do
    let(:user) { create(:user) }
    let(:topic) { create(:topic, user: user) }
    it "送信、受信メッセージがあれば登録できる" do
      expect(topic).to be_valid
    end
  end
  context "登録が成功する場合" do
    let(:user) { create(:user) }
    let(:topic) { Topic.new(send_message: "a"*149, receive_message: "a"*149, user: user) }
    it "149文字以下なら登録できる" do
      expect(topic).to be_valid
    end
  end

  context "登録が失敗する場合" do
    let(:topic) { Topic.new(send_message: "") }
    it "送信メッセージがなければ登録できない" do
      expect(topic).to_not be_valid
      expect(topic[:send_message]).to be_empty
      expect(topic.errors.details).to_not be_empty
    end
  end

  context "登録が失敗する場合" do
    let(:topic) { Topic.new(receive_message: "") }
    it "受信メッセージがなければ登録できない" do
      expect(topic).to_not be_valid
      expect(topic[:receive_message]).to be_empty
      expect(topic.errors.details).to_not be_empty
    end
  end

  context "登録が失敗する場合" do
    let(:topic) { Topic.new(send_message: "a"*155, receive_message: "a"*200) }
    it "150文字以上だと登録できない" do
      expect(topic.send_message.length).to be >= 150
      expect(topic).to_not be_valid
      expect(topic.errors.details).to_not be_empty
    end
  end

end
