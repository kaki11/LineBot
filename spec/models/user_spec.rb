require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context "登録が成功する場合" do
    it "名前とメールアドレスとパスワードがあれば登録できる" do
      expect(user.errors.details).to be_empty
      expect(create(:user)).to be_valid
    end
    it "正しく保存されている" do
      expect(user.name).to eq("testuter")
    end
  end
  
  context "登録が失敗する場合" do
    let(:user) { User.new(name: "") }
    it "名前がないとき" do
      expect(user).to_not be_valid
      expect(user[:name]).to be_empty
      expect(user.errors.details).to_not be_empty
    end
  end
  context "登録が失敗する場合" do
    let(:user) { User.new(email: "") }
    it "メールアドレスがないとき" do
      expect(user).to_not be_valid
      expect(user[:email]).to be_empty
      expect(user.errors.details).to_not be_empty
    end
  end

  context "登録が失敗する場合" do
    let(:user) { User.create(email: "user1@example.com") }
    it "メールアドレスが重複している" do
      expect(User.new(email: user.email)).to_not be_valid
      expect(user.errors.details).to_not be_empty
    end
  end

  context "登録が失敗する場合" do
    let(:user) { User.create }
    it "パスワードが暗号化されているか" do
      expect(user.password_digest).to_not eq "password"
    end
  end

  context "登録が失敗する場合" do
    let(:user) { User.create(password: "password", password_confirmation: "passwoord") }
    it "パスワードと確認用パスワードが異なる場合保存できない" do
      expect(user).to_not be_valid 
      expect(user.password).to_not eq "passwoord"
    end
  end

end
