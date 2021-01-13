# テーブル設計

## users テーブル

| Colum     | Type    | Options     |
| --------- | ------- | ----------- |
| email     | string  | null: false |
| encrypted | string  | null: false |
| nickname  | string  | null: false |

### Association

- has_many :cats
- has_many :comments

## cats テーブル

| Colum         | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| nickname      | string     | null: false                    |
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