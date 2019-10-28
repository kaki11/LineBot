require 'rails_helper'

RSpec.describe HomeController, type: :request do
  describe "GET #index" do
    it "リクエストが成功すること" do
      get root_path
      expect(response).to render_template :index
    end

    it "新規登録ページに遷移すること" do
      get signup_path
      expect(response).to render_template :new
    end

    it "ログインページに遷移すること" do
      get login_path
      expect(response).to render_template :new
    end

  end
end