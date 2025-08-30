# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data
Post.destroy_all
User.destroy_all

# Create sample users
users = [
  { name: "田中太郎", email: "tanaka@example.com" },
  { name: "佐藤花子", email: "sato@example.com" },
  { name: "山田次郎", email: "yamada@example.com" }
]

created_users = users.map do |user_attrs|
  User.create!(user_attrs)
end

# Create sample posts
posts = [
  { title: "Ruby on Rails入門", content: "Ruby on RailsでAPIを作成する方法について説明します。", user: created_users[0] },
  { title: "Dockerの便利さ", content: "Docker環境を使うことで開発環境の構築が簡単になります。", user: created_users[0] },
  { title: "PostgreSQLのメリット", content: "PostgreSQLは高性能で信頼性の高いデータベースです。", user: created_users[1] },
  { title: "API設計のベストプラクティス", content: "RESTful APIを設計する際のポイントをまとめました。", user: created_users[1] },
  { title: "CORS設定の重要性", content: "フロントエンドからのAPIアクセスにはCORS設定が必要です。", user: created_users[2] }
]

posts.each do |post_attrs|
  Post.create!(post_attrs)
end

puts "Created #{User.count} users and #{Post.count} posts"
