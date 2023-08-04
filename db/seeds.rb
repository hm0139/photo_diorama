# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Faker::Config.locale = :ja

20.times do |n|
  name = Gimei.name
  address = Gimei.address
  User.create!(
    user_name: Faker::Name.initials(number: 5),
    email: "test#{n + 1}@gmail.com",
    password: "testuser#{n + 1}",
    password_confirmation: "testuser#{n + 1}",
    name: name.kanji,
    reading_name: name.katakana.gsub(/ /,""),
    postal_code: Faker::Address.zip_code,
    prefectures: Faker::Number.between(from: 1, to: 47),
    city: address.city.kanji,
    building_name: "",
    kind: n % 2 == 0 ? "1" : "0",
    financial_institution: "澤村銀行",
    branch: "#{address.city.kanji}支店",
    deposit: "1",
    account_number: "0123456",
    account_holder: name.katakana.gsub(/ /,"")
  )
end

n = 1
User.all.each do |user|
  next if user.kind == 1
  user.commissions.create!(
    title: "テスト#{n}_#{Faker::Lorem.sentence}",
    description: Faker::Lorem.sentence,
    limit_date: Date.today + Faker::Number.between(from: 7, to: 60),
    reward: Faker::Number.between(from: 5, to: 1000) * 1000,
    directly: false
  )
  n += 1
end
