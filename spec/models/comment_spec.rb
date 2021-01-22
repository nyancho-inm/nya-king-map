require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe "コメント投稿" do
    context "コメントできるとき" do
      it "textがあれば投稿できる" do
        expect(@comment).to be_valid
      end
    end 

    context "コメントできないとき" do
      it "textが空では登録できない" do
        @comment.text = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "コメントを入力してください"
      end
      it "userが紐づいていないとコメントできない" do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "ユーザー情報を入力してください"
      end
      it "catが紐づいていないとコメントできない" do
        @comment.cat = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "猫情報を入力してください"
      end
    end
  end

end

