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

RSpec.describe '猫情報編集', type: :system do
  before do
    @cat1 = FactoryBot.create(:cat)
    @cat2 = FactoryBot.create(:cat)
  end

  context '編集ができるとき' do
    it 'ログインユーザーは自分の投稿を編集できる' do
      # cat1を投稿したユーザーでログイン
      visit new_user_session_path
      fill_in 'email', with: @cat1.user.email
      fill_in 'password', with: @cat1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 詳細ページへ遷移
      visit cat_path(@cat1)
      # cat1に編集ボタンがあることを確認する
      expect(page).to have_content('編集')
      # 編集ページへ遷移する
      visit edit_cat_path(@cat1)
      # 投稿内容が存在することを確認する
      expect(
        find('#cat-info').value
      ).to eq @cat1.message
      
      expect(
        find('#prefecture').value
      ).to eq "#{@cat1.prefecture_id}"

      expect(
        find('#cat-area').value
      ).to eq @cat1.area

      expect(
        find('#cat-place').value
      ).to eq @cat1.place
      # 編集する
      fill_in 'cat-info', with: "#{@cat1.message}+編集したメッセージ"
      fill_in 'cat-area', with: "#{@cat1.area}+編集したエリア"
      fill_in 'cat-place', with: "#{@cat1.place}+編集した場所"
      # 編集してもCatモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Cat.count }.by(0)
      # 詳細ページに遷移する
      visit cat_path(@cat1)
      # 詳細ページには変更した内容が存在することを確認する
      expect(page).to have_content("#{@cat1.message}+編集したメッセージ")
      expect(page).to have_content("#{@cat1.area}+編集したエリア")
      expect(page).to have_content("#{@cat1.place}+編集した場所")
    end
  end
  context '編集できないとき' do
    it 'ログインしたユーザーは自分以外の投稿の編集画面には遷移できない'do
      # cat1を投稿したユーザーでログイン
      visit new_user_session_path
      fill_in 'email', with: @cat1.user.email
      fill_in 'password', with: @cat1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # cat2の詳細ページに編集ボタンが無いことを確認する
      visit cat_path(@cat2)
      expect(page).to have_no_content('編集')
    end
    it 'ログインしていないユーザーは編集画面には遷移できない' do
      visit root_path
      visit cat_path(@cat1)
      expect(page).to have_no_content('編集')
      visit cat_path(@cat2)
      expect(page).to have_no_content('編集')
    end
  end
end

RSpec.describe '削除', type: :system do
  before do
    @cat1 = FactoryBot.create(:cat)
    @cat2 = FactoryBot.create(:cat)
  end

  context '削除できるとき' do
    it 'ログインしたユーザーは自分の投稿を削除できる' do
      # cat1を投稿したユーザーでログイン
      visit new_user_session_path
      fill_in 'email', with: @cat1.user.email
      fill_in 'password', with: @cat1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 詳細ページへ遷移
      visit cat_path(@cat1)
      # cat1に削除ボタンがあることを確認する
      expect(page).to have_content('削除')
      find_link("削除", href:cat_path(@cat1)).click
    end
  end
  context '削除できないとき' do
    it 'ログインしたユーザーは自分以外の投稿を削除できない'do
      # cat1を投稿したユーザーでログイン
      visit new_user_session_path
      fill_in 'email', with: @cat1.user.email
      fill_in 'password', with: @cat1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # cat2の詳細ページに編集ボタンが無いことを確認する
      visit cat_path(@cat2)
      expect(page).to have_no_content('削除')
    end
    it 'ログインしていないユーザーは削除できない' do
      visit root_path
      visit cat_path(@cat1)
      expect(page).to have_no_content('削除')
      visit cat_path(@cat2)
      expect(page).to have_no_content('削除')
    end
  end
end

RSpec.describe "詳細", type: :system do
  before do
    @cat = FactoryBot.create(:cat)    
  end
  it 'ログインユーザーは詳細ページに遷移してコメント投稿欄が表示される' do
    visit new_user_session_path
    fill_in 'email', with: @cat.user.email
    fill_in 'password', with: @cat.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    visit cat_path(@cat)
    expect(page).to have_selector ("img[src$='test_image.png']")
    expect(page).to have_content("#{@cat.message}")
    expect(page).to have_content("#{@cat.area}")
    expect(page).to have_content("#{@cat.place}")
    expect(page).to have_content("#{@cat.prefecture.name}")
    expect(page).to have_selector 'form'
  end
  it 'ログインしていないユーザーは詳細ページに遷移してもコメント投稿欄が表示されない' do
    visit root_path
    visit cat_path(@cat)
    expect(page).to have_selector ("img[src$='test_image.png']")
    expect(page).to have_content("#{@cat.message}")
    expect(page).to have_content("#{@cat.area}")
    expect(page).to have_content("#{@cat.place}")
    expect(page).to have_content("#{@cat.prefecture.name}")
    expect(page).to have_no_content 'コメント'
  end
end
