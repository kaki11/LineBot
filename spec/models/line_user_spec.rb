require 'rails_helper'

RSpec.describe LineUser, type: :model do
  it "userはline_uidがあれば登録できる" do
    expect(FactoryBot.create(:line_user)).to be_valid
  end
  
end
