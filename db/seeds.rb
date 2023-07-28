# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

20.times do |n|
  User.create!(
    user_name: "test#{n + 1}",
    email: "test#{n + 1}@gmail.com",
    password: "testuser#{n + 1}",
    password_confirmation: "testuser#{n + 1}",
    name: "テスト#{n + 1}",
    reading_name: "テスト",
    postal_code: "999-9999",
    prefectures: "13",
    city: "渋谷区",
    building_name: "シブヤマンション",
    kind: n % 2 == 0 ? "1" : "0",
    financial_institution: "澤村銀行",
    branch: "渋谷支店",
    deposit: "1",
    account_number: "0123456",
    account_holder: "テスト"
  )
end

User.all.each do |user|
  next if user.kind == 1
  user.commissions.create!(
    title: "依頼",
    description: "依頼説明文",
    limit_date: Date.today + 7,
    reward: "100000",
    directly: false
  )
end
