require 'rails_helper'

RSpec.describe CatsController, type: :request do

  before do
    @cat = FactoryBot.create(:cat)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq 200
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みの画像が存在する" do
      get root_path
      expect(response.body).to include "test_image.png"
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みの都道府県が存在する" do
      get root_path
      expect(response.body).to include @cat.prefecture.name
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みの市町村が存在する" do
      get root_path
      expect(response.body).to include @cat.area
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのニックネームが存在する" do
      get root_path
      expect(response.body).to include @cat.user.nickname
    end
    it "indexアクションにリクエストするとレスポンスに検索フォームが存在する" do
      get root_path
      expect(response.body).to include "キーワードから探す"
    end
    it "indexアクションにリクエストするとレスポンスに検索フォームが存在する" do
      get root_path
      expect(response.body).to include "エリアで探す"
    end
    it "indexアクションにリクエストするとレスポンスに投稿フォームが存在する" do
      get root_path
      expect(response.body).to include "投稿する"
    end
    it "indexアクションにリクエストするとレスポンスに投稿フォームが存在する" do
      get root_path
      expect(response.body).to include "MAPPING"
    end
    it "indexアクションにリクエストするとレスポンスに新規登録フォームが存在する" do
      get root_path
      expect(response.body).to include "新規登録"
    end
    it "indexアクションにリクエストするとレスポンスにログインフォームが存在する" do
      get root_path
      expect(response.body).to include "ログイン"
    end
    it "indexアクションにリクエストするとレスポンスにゲストログインフォームが存在する" do
      get root_path
      expect(response.body).to include "おためしログイン"
    end
    it "indexアクションにリクエストするとレスポンスにルートロゴが存在する" do
      get root_path
      expect(response.body).to include "Nyaking-map"
    end
  end

  describe "GET #show" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる " do
      get cat_path(@cat)
      expect(response.status).to eq 200
    end
    it "showアクションにリクエストすると投稿者のニックネームが存在する " do
      get cat_path(@cat)
      expect(response.body).to include @cat.user.nickname
    end
    it "showアクションにリクエストすると投稿者のメッセージが存在する " do
      get cat_path(@cat)
      expect(response.body).to include @cat.message
    end
    it "showアクションにリクエストすると投稿者の都道府県が存在する " do
      get cat_path(@cat)
      expect(response.body).to include @cat.prefecture.name
    end
    it "showアクションにリクエストすると投稿者の市町村が存在する " do
      get cat_path(@cat)
      expect(response.body).to include @cat.area
    end
    it "showアクションにリクエストすると投稿者の会えた場所が存在する " do
      get cat_path(@cat)
      expect(response.body).to include @cat.place
    end
    it "showアクションにリクエストすると投稿者の画像が存在する " do
      get cat_path(@cat)
      expect(response.body).to include "test_image.png"
    end
    it "showアクションにリクエストするとコメント一覧が存在する " do
      get cat_path(@cat)
      expect(response.body).to include "comment"
    end
  end
end
