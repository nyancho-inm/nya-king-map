# Nyaking-Map

 「Nyaking-Map」は地域猫を通じてコミュニティを作るアプリケーションです。都道府県各地の地域猫の情報を
 ユーザーが共有し、みんなで地域猫を可愛がり、地域のアイコンにしていくことで、保護猫活動への関心を高める
 手助けや、地域活性化の手助けを目的としています。


# URL

https://www.nyakingmap.com/

- トップページヘッダーにゲストログインリンクを設置しております。


# ページサンプル

![18ec2960e218fdc25a762eb293203e4a](https://user-images.githubusercontent.com/75053805/106352094-ead89600-6323-11eb-8836-26f196549a1e.jpg)

![62c551f3cb89b734e18d3e73ec9b9a93](https://user-images.githubusercontent.com/75053805/106352186-502c8700-6324-11eb-9c2d-79fd355380d5.jpg)

![5c3131362d225714ce085f5f98003d53](https://user-images.githubusercontent.com/75053805/106352237-a3063e80-6324-11eb-9994-9dc816032164.jpg)

<img width="1735" alt="eb3c2d7dc5910c33390287c985d5527a" src="https://user-images.githubusercontent.com/75053805/106352252-c7621b00-6324-11eb-82b3-d2ca4a5cae75.png">




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