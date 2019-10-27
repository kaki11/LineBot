require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do

    it "全ての値が存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "nameが空では登録できないこと" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "emailが空では登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "passwordが空では登録できないこと" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "password_confirmationが空では登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "パスワードと確認用パスワードが異なる場合保存できないこと" do
      user = build(:user, password: "Pasword00", password_confirmation: "Pasword0000")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "nameが16文字以上であれば登録できないこと" do
      user = build(:user, name: "a"*16)
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 15 characters)")
    end

    it "重複したemailが存在する場合登録できないこと" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "nameが15文字以下では登録できること" do
      user = build(:user, name: "a"*15)
      expect(user).to be_valid
    end

    it "passwordが8文字以上であれば登録できること" do
      user = build(:user, password: "Pasword00", password_confirmation: "Pasword00")
      user.valid?
      expect(user).to be_valid
    end

    it "passwordが32文字以下であれば登録できること" do
      user = build(:user, password: "a"*30+"A0", password_confirmation: "a"*30+"A0")
      user.valid?
      user.valid?expect(user).to be_valid
    end

    it "passwordが33文字以上であれば登録できないこと" do
      user = build(:user, password: "a"*35+"A0", password_confirmation: "a"*35+"A0")
      user.valid?
      expect(user.errors[:password]).to include("is too long (maximum is 32 characters)")
    end

    it "パスワードが暗号化されているか" do
      user = create(:user, password: "Pasword00", password_confirmation: "Pasword00")
      expect(user.password_digest).to_not eq "Pasword00"
    end
  end
end