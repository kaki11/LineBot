require 'rails_helper'

RSpec.describe LineUser, type: :request do
  describe "ラインログイン" do
    context "リクエストが成功した場合" do
      let(:user) { create(:user) }
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
      end

      let(:params) do
        { params: { line_user: attributes_for(:line_user, user_id: user.id, line_id: "line_id")} }
      end
      xit "データベースに保存される" do
        expect{ get show_url params }.to change(LineUser, :count).by(1)
      end
      xit "indexにページ遷移" do
        get show_url params
        expect(response.status).to eq 200
      end
    end
  end
end

RSpec.describe Linebot, type: :request do
  describe "callbackが呼ばれた場合" do
    context "リクエストが成功した場合" do
      xit "連携がまだのとき" do
      end
      xit "メッセージが返ってくるか" do
      end
    end
  end

end