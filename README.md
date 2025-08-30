# Ruby on Rails API Demo with Docker

Ruby on Rails を使ったシンプルなAPI専用のデモアプリケーションです。Docker環境で動作するため、Windows環境でも安定して動作します。

## 特徴

- **Rails 8.0** API専用アプリケーション
- **PostgreSQL** データベース
- **Docker Compose** による環境構築
- **CORS対応** でフロントエンドからのアクセス可能
- **RESTful API** エンドポイント
- **ヘルスチェック** 機能

## 必要な環境

- Docker
- Docker Compose

## セットアップ

1. **リポジトリをクローンまたはダウンロード**

2. **Docker Composeでアプリケーションを起動**
```bash
docker-compose up --build
```

3. **データベースの準備とシードデータの作成**
```bash
# 別のターミナルで実行
docker-compose exec web rails db:create
docker-compose exec web rails db:migrate
docker-compose exec web rails db:seed
```

4. **動作確認**
- アプリケーション: http://localhost:3000
- ヘルスチェック: http://localhost:3000/api/v1/health

## API エンドポイント

### ヘルスチェック
```
GET /api/v1/health
```

### ユーザー管理
```
GET    /api/v1/users        # ユーザー一覧
GET    /api/v1/users/:id    # ユーザー詳細
POST   /api/v1/users        # ユーザー作成
PUT    /api/v1/users/:id    # ユーザー更新
DELETE /api/v1/users/:id    # ユーザー削除
```

### 投稿管理
```
GET    /api/v1/posts        # 投稿一覧
GET    /api/v1/posts/:id    # 投稿詳細
POST   /api/v1/posts        # 投稿作成
PUT    /api/v1/posts/:id    # 投稿更新
DELETE /api/v1/posts/:id    # 投稿削除
```

## 使用例

### ユーザー作成
```bash
curl -X POST http://localhost:3000/api/v1/users \
  -H "Content-Type: application/json" \
  -d '{"user": {"name": "テストユーザー", "email": "test@example.com"}}'
```

### 投稿作成
```bash
curl -X POST http://localhost:3000/api/v1/posts \
  -H "Content-Type: application/json" \
  -d '{"post": {"title": "テスト投稿", "content": "投稿の内容", "user_id": 1}}'
```

### ユーザー一覧取得
```bash
curl http://localhost:3000/api/v1/users
```

## データモデル

### User
- `id` (主キー)
- `name` (文字列、必須)
- `email` (文字列、必須、ユニーク)
- `created_at`, `updated_at`

### Post
- `id` (主キー)
- `title` (文字列、必須)
- `content` (テキスト、必須)
- `user_id` (外部キー、必須)
- `created_at`, `updated_at`

## 開発用コマンド

```bash
# コンテナ内でRailsコンソールを起動
docker-compose exec web rails console

# テストデータをリセット
docker-compose exec web rails db:reset

# ログを確認
docker-compose logs web

# コンテナを停止
docker-compose down
```

## 技術スタック

- Ruby 3.4.5
- Rails 8.0.2
- PostgreSQL 15
- Docker & Docker Compose
- Rack-CORS (CORS対応)

## トラブルシューティング

### Windowsでのパフォーマンス問題
- Docker DesktopのWSL2バックエンドを使用することを推奨
- ボリュームマウントによりライブリロードが動作します

### データベース接続エラー
```bash
# データベースコンテナを再起動
docker-compose restart db
# データベースの状態を確認
docker-compose exec db psql -U postgres -l
```