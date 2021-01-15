require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録できるとき" do
      it "nickname,email、password、password_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "passwordとpassword_confirmationが6文字以上なら登録できる" do
        @user.password = "123aaa"
        @user.password_confirmation = "123aaa"
        expect(@user).to be_valid
      end
      it "passwordとpassword_confirmationが英数混合なら登録できる" do
        @user.password = "123aaa"
        @user.password_confirmation = "123aaa"
        expect(@user).to be_valid
      end
    end
    context "新規登録できないとき" do
      it "nicknameが空では登録できない" do  
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it "重複したemailが存在する場合は登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Eメールはすでに存在します"
      end
      it "emailに@がないと登録できない" do
        @user.email = "testgmail.com"
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールは不正な値です"
      end
      it "passwordとpassword_confirmationが一致しないと登録できない" do
        @user.password = "a123456"
        @user.password_confirmation = "a1234567"
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it "passwordが5文字以下では登録できない" do
        @user.password = "12345"
        @user.password_confirmation = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは6文字以上で入力してください"
      end
      it "passwordとpassword_confirmationが英語だけでは登録できない" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは英語と数字を使用してください"
      end
      it "passwordとpassword_confirmationが数字だけでは登録できない" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは英語と数字を使用してください"
      end
    end
  end
end
