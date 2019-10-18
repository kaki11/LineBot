require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:topic) { build(:topic) }
  let(:line_user) { build(:line_user) }

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

  it "メールアドレスが重複していたら登録できない" do
    user1 = FactoryBot.create(:user, name: "user1", email: "user1@example.com")
    expect(FactoryBot.build(:user, name: "user2", email: user1.email)).to_not be_valid
  end

  it "パスワードが暗号化されているか" do
    user = FactoryBot.create(:user)
    expect(user.password_digest).to_not eq "password_digest"
  end

  it "パスワードと確認用パスワードが異なる場合保存できない" do 
    expect(FactoryBot.build(:user, password:"password", password_digest: "passward")).to_not be_valid 
  end 
 
end
