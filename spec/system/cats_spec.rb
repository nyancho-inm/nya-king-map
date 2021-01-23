require 'rails_helper'

RSpec.describe "猫情報投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @cat = FactoryBot.build(:cat) 
    
  end

  context '投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページへ移動する
      visit new_cat_path
      # 情報を入力する
      attach_file "cat[images][]", "public/images/test_image.png"
      fill_in 'cat-info', with: @cat.message
      select '東京都', from: 'prefecture'
      fill_in 'cat-area', with: @cat.area
      fill_in 'cat-place', with: @cat.place
      # 送信するとCatモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Cat.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページに投稿内容が存在することを確認する
      expect(page).to have_selector ("img[src$='test_image.png']")

    end
  end
  context '投稿できないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 投稿ボタンをおすとログインページに遷移する
      find_link("投稿する", href: "/cats/new").click
    end
  end
end

