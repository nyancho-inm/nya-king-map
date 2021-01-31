# Nyaking-Map

 「Nyaking-Map」は地域猫を通じてコミュニティを作るアプリケーションです。都道府県各地の地域猫の情報を
 ユーザーが投稿、コメントを通じて共有でき、みんなで地域猫をアイコン化していけるサービスです。


# URL

https://www.nyakingmap.com/

- トップページヘッダーにゲストログインリンクを設置しております。


# ページサンプル

![18ec2960e218fdc25a762eb293203e4a](https://user-images.githubusercontent.com/75053805/106352094-ead89600-6323-11eb-8836-26f196549a1e.jpg)

![62c551f3cb89b734e18d3e73ec9b9a93](https://user-images.githubusercontent.com/75053805/106352186-502c8700-6324-11eb-9c2d-79fd355380d5.jpg)

![5c3131362d225714ce085f5f98003d53](https://user-images.githubusercontent.com/75053805/106352237-a3063e80-6324-11eb-9994-9dc816032164.jpg)

<img width="1735" alt="eb3c2d7dc5910c33390287c985d5527a" src="https://user-images.githubusercontent.com/75053805/106352252-c7621b00-6324-11eb-82b3-d2ca4a5cae75.png">


# 制作背景

現在コロナ禍の自粛期間中で外出を控え、気分転換に散歩をする人が増えています。私自身もその一人で、人の多い観光地や
テーマパークへの外出が極端に減り、せめてもの気分転換にと近所を散歩することが増えました。
そんな中たまたま散歩中に猫と遭遇できたコースがあり、毎回会えることを楽しみにするようになった経験があります。

そこで、同じような人が情報を提供し合い、地域猫に会える機会が増えれば毎日が少しでも楽しくなるのではないかと考え、
アプリケーションの制作を決意しました。

また、地域猫が有名な観光スポットへ猫に会うために足を運ぶ人も多く、コロナ禍で密集を避ける人にも気軽に出かけられる場所
として良いのではないか。
もし地域のアイコンとなる看板猫が生まれれば地域活性化にも繋がるのではないか、と考えました。

このサービスを通じて、日常に少しでも楽しみを見つけられる人が増えて欲しいと思います。


# 使用技術

- HTML/CSS
- Ruby 2.6.5
- Rails 6.0.0
- MySQL 5.6.50
- Linux
- Nginx(Web Server
- Unicorn(Application Server)
- Git/GitHub
- Docker 20.10.0
- docker-compose 1.27.4
- Capistrano
- AWS EC2


# 機能一覧

## ユーザー機能

- ユーザー新規登録・ログイン機能(Gem: devise)
- ゲストログイン

##  投稿機能

- 新規投稿機能(画像投稿用に Gem: ActiveStorage 使用)
- 投稿時画像プレビュー機能
- 投稿一覧表示機能
- 投稿詳細表示機能
- 投稿削除機能
- ページネーション機能(Gem: kaminari)

## コメント機能

- コメント新規投稿機能
- コメント削除機能

## 検索機能

- キーワード検索機能
- 都道府県検索機能(Gem: ransack)

## いいね機能

- いいね・いいね解除機能

## テスト機能

- RSpec/Rubocop テスト機能
- エラーメッセージの日本語表示



# テーブル設計

## users テーブル

| Colum     | Type    | Options                   |
| --------- | ------- | ------------------------- |
| email     | string  | null: false, unique: true |
| encrypted | string  | null: false               |
| nickname  | string  | null: false               |

### Association

- has_many :cats
- has_many :comments

## cats テーブル

| Colum         | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| message       | text       |                                |
| prefecture_id | integer    | null: false                    |
| area          | string     | null: false                    |
| place         | string     |                                |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments

## comments テーブル

| Colum         | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| comment       | text       | null: false                    |
| user          | references | null: false, foreign_key: true |
| cat           | references | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :cat