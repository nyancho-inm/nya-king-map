# Nyaking-Map

 「Nyaking-Map」は地域猫を通じてコミュニティを作るアプリケーションです。都道府県各地の地域猫の情報を
 ユーザーが共有し、みんなで地域猫を可愛がり、地域のアイコンにしていくことで、保護猫活動への関心を高める
 手助けや、地域活性化の手助けを目的としています。

# URL

(https://www.nyakingmap.com/)

  *トップページヘッダーにゲストログインリストを設置しております。

  

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