require "rails_helper"

RSpec.describe "リクエストテスト", type: :request do
  describe "ログインユーザーがいるとき" do
    let(:user) { create(:user) }
    let(:line_user) { create(:line_user, user: user) }
  end

    it "new" do
      get signup_path
      expect(response).to render_template(:new)
    end

    it "not found" do
      expect { get "/hoge" }.to raise_error(ActionController::RoutingError)
    end
  end

  describe "セッションをスタブする" do
    context do
      let(:user) { create(:user) }
      before 'ユーザーIDをセッションから取り出せるようにする' do
        allow_any_instance_of(ActionDispatch::Request)
          .to receive(:session).and_return(user_id: user.id)
      end

      it "ログインユーザーがいればshowに遷移する" do
        get "/users/#{user.id}"
        expect(response).to render_template(:show)
      end
      
      it "ログインユーザーがいればeditに遷移する" do
        get "/users/#{user.id}/edit"
        expect(response).to render_template(:edit)
      end

    end
  end

  describe "ログインユーザーがいないとき" do
    let(:user) { create(:user) }
    it "show（ログイン画面にとぶ）" do
      get "/users/#{user.id}"
      expect(response).to redirect_to login_path
    end

    it "edit（ログイン画面にとぶ）" do
      get "/users/#{user.id}/edit"
      expect(response).to redirect_to login_path
    end
  end

  describe "トピックの作成" do
    it "成功したとき" do
    end

    it "失敗したとき" do
    end
  end

  describe "トピックの編集" do
    it "update" do
    end
  end

  describe "トピックの削除" do
    it "delete" do
    end
  end