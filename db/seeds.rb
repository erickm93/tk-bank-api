# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## Users

user_params = [
  { first_name: 'Erick', last_name: 'Takeshi', email: 'erick@email.com' },
  { first_name: 'Jãozim', last_name: 'Brabo', email: 'jaozim@email.com' },
  { first_name: 'Luizodia', last_name: 'Myth', email: 'themyth@email.com' }
]

user_ids = []

user_params.each do |params|
  user_ids.push(User.create!(params).id)
end

## Accounts

account_params = [
  { balance: Money.new(10000) },
  { balance: Money.new(1000000) },
  { balance: Money.new(20000) }
]

account_params.each_with_index do |params, index|
  Account.create!(params.merge(user_id: user_ids[index]))
end
