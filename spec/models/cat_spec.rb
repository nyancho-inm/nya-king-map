require 'rails_helper'

RSpec.describe Cat, type: :model do
  before do
    @cat = FactoryBot.build(:cat)
  end

  describe "猫情報投稿" do
    context "投稿できるとき" do
      it "全て入力していれば投稿できる" do
        expect(@cat).to be_valid
      end
      it "messageが空でも投稿できる" do
        @cat.message = nil
        expect(@cat).to be_valid
      end
      it "placeが空でも投稿できる" do
        @cat.place = nil
        expect(@cat).to be_valid
      end
    end
    context "投稿できないとき" do
      it "imageが空では投稿できない" do
        @cat.images = nil
        @cat.valid?
        expect(@cat.errors.full_messages).to include "画像を入力してください"
      end
      it "prefecture_idが空では投稿できない" do
        @cat.prefecture_id = nil
        @cat.valid?
        expect(@cat.errors.full_messages).to include "都道府県を入力してください"
      end
      it "prefecture_idが0では投稿できない" do
        @cat.prefecture_id = 0
        @cat.valid?
        expect(@cat.errors.full_messages).to include "都道府県は--以外を選んでください"
      end
      it "areaが空では投稿できない" do
        @cat.area = nil
        @cat.valid?
        expect(@cat.errors.full_messages).to include "市町村を入力してください"
      end
      it "userが紐づいていないと投稿できない" do
        @cat.user = nil
        @cat.valid?
        expect(@cat.errors.full_messages).to include "ユーザー情報を入力してください"
      end
    end
  end
end
