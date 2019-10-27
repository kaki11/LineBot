require 'rails_helper'

RSpec.describe LineUser, type: :model do
  describe '#create' do

    context "登録が成功する場合" do
      let(:user) { create(:user) }
      let(:line_user) { create(:line_user, user: user) }
      it "userはline_uidがあれば登録できる" do
        expect(line_user).to be_valid
      end
    end

  end
end
