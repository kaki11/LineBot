require "rails_helper"

RSpec.describe TopicsController, type: :request do
  describe "セッションをスタブする" do
    context do
      let(:user) { create(:user) }
      before 'ユーザーIDをセッションから取り出せるようにする' do
        allow_any_instance_of(ActionDispatch::Request)
          .to receive(:session).and_return(user_id: user.id)
      end

      it 'リクエストが成功すること' do
        get user_path(user)
        expect(response.status).to eq 200
      end

      it '投稿一覧が表示されていること' do
        get user_path(user)
        expect(response.body).to include "List"
      end

      describe '投稿が成功するとき' do
        let(:params) do
          { params: { topic: attributes_for(:topic, user_id: 1), user: attributes_for(:user, id: 1)} }
        end

        it 'データベースに保存されているか' do
          expect{ post topics_url user, params }.to change(Topic, :count).by(1)
        end

        it 'showにページ遷移' do
          post topics_url user, params
          expect(response).to redirect_to user_path(user)
        end

        xit '投稿が表示されること' do
          post topics_url user, params
          expect(response.body).to include "メッセージ"
        end
      end

      describe "投稿が失敗するとき" do
        let(:params) do
          { params: { topic: attributes_for(:topic, send_message: "", user_id: 1), user: attributes_for(:user, id: 1)} }
        end

        it 'エラーメッセージが表示されること' do
          post topics_url user, params
          expect(response.body).to include "登録に失敗しました"
        end

        it 'ページがレンダリングされること' do
          post topics_url user, params
          expect(response).to render_template :new
        end
      end

      describe "投稿が更新されるとき" do
        it '' do
        end
      end

      describe "投稿が削除されるとき" do
        let!(:user_topic) { create(:topic, user_id: user.id) }
        it 'リクエストが成功すること' do
          delete topic_url user_topic
          expect(response.status).to eq 302
        end

        it '投稿が削除されること' do
          expect do
            delete topic_url user_topic
          end.to change(Topic, :count).by(-1)
        end

        it 'ページがレンダリングされること' do
          delete topic_url user_topic
          expect(response).to redirect_to user_path(user)
        end
      end

    end
  end
end