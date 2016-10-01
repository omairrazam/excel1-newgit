# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create({email: 'admin@example.com', password: '11159357', password_confirmation: '11159357', is_admin: 'true', account_active: 'true'})

#PaypalPackage.create({subscription_type: 'M', amount:60, period: 24, cycles: 24 })
#PaypalPackage.create({subscription_type: 'Y', amount:612, period: 5, cycles: 5 })
