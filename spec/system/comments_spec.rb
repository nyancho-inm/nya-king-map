require 'rails_helper'

RSpec.describe "コメント投稿", type: :system do
  before do
    @cat = FactoryBot.create(:cat)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーは詳細ページでコメントできる' do
    # ログインする
    sign_in(@cat.user)
    # 詳細ページに遷移する
    visit cat_path(@cat)
    # フォームに入力する
    fill_in 'comment-text', with: @comment
    # コメント送信すると。Commentモデルのカウントが1上がることを確認する
    expect{
      click_on("コメントする")
    }.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq cat_path(@cat)
    # コメント内容が含まれることを確認する
    expect(page).to have_content @comment
  end
end
