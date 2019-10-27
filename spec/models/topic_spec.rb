require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe '#create' do

    context '保存できる場合' do
      let(:user) { create(:user) }
      
      it '送信、受信メッセージがあるとき' do
        expect(create(:topic)).to be_valid
      end

      it '149文字以下なら登録できる' do
        topic = build(:topic, send_message: "a"*149, receive_message: "a"*149, user_id: user.id)
        expect(topic).to be_valid
      end
    end

    context '保存できない場合' do
      it '送信メッセージがないとき' do
        topic = build(:topic, send_message: "")
        topic.valid?
        expect(topic.errors[:send_message]).to include("can't be blank")
      end

      it "受信メッセージがないとき" do
        topic = build(:topic, receive_message: "")
        topic.valid?
        expect(topic.errors[:receive_message]).to include("can't be blank")
      end
 
      it "150文字以上だと登録できない" do
        topic = build(:topic, send_message: "a"*155, receive_message: "a"*200)
        topic.valid?
        expect(topic.errors[:send_message]).to include("is too long (maximum is 150 characters)")
        expect(topic.errors[:receive_message]).to include("is too long (maximum is 150 characters)")
      end

      it 'userがいないとき' do
        topic = build(:topic, user_id: nil)
        topic.valid?
        expect(topic.errors[:user]).to include("must exist")
      end

    end
  end
end