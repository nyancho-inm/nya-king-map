require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録できるとき' do
    it '正しい情報を入力すれば新規登録できてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録へのボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ遷移
      visit new_user_registration_path
      # ユーザー情報を入力する 
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      # 会員登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }. by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # ログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンが表示されていないことを確認する 
      expect(page).to have_no_content('新規登録')
      #登録者のニックネームが表示されることを確認する
      expect(page).to have_content(@user.nickname)
    end
  end
  context '新規登録できないとき' do
      it '誤った情報では新規登録できずページに留まる' do
        # トップページに移動する
        visit root_path
        # トップページに新規登録へのボタンがある
        expect(page).to have_content('新規登録')
        # 新規登録ページへ遷移
        visit new_user_registration_path
        # ユーザー情報を入力する 
        fill_in 'nickname', with: ""
        fill_in 'email', with: ""
        fill_in 'password', with: ""
        fill_in 'password-confirmation', with: ""
        # 会員登録ボタンを押すとユーザーモデルのカウントが上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }. by(0)
        #新規登録ページに留まる
        expect(current_path).to eq "/users"
        #エラーメッセージが出ることを確認する
        expect(page).to have_content('Eメールを入力してください')
        expect(page).to have_content('パスワードを入力してください')
        expect(page).to have_content('パスワードは英語と数字を使用してください')
        expect(page).to have_content('ニックネームを入力してください')
      end
   end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインできるとき' do
    it '保存されているユーザー情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録へのボタンがある
      expect(page).to have_content('ログイン')
      # 新規登録ページへ遷移
      visit new_user_session_path
      # ユーザー情報を入力する 
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # ログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンが表示されていないことを確認する 
      expect(page).to have_no_content('新規登録')
      #登録者のニックネームが表示されることを確認する
      expect(page).to have_content(@user.nickname)
    end    
  end
  context 'ログインできないとき' do
    it '保存されているユーザー情報と合致いsないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録へのボタンがある
      expect(page).to have_content('ログイン')
      # 新規登録ページへ遷移
      visit new_user_session_path
      # ユーザー情報を入力する 
      fill_in 'email', with: ""
      fill_in 'password', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      expect(current_path).to eq "/users/sign_in"
      #エラーメッセージが出ることを確認する
      expect(page).to have_content('Eメールまたはパスワードが違います。')     
    end 
  end
end
