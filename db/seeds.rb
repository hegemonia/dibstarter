# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

products = Product.create([{ name: 'Design One', design_id: '1', preview_url: '/images/coupon.jpg'},
	{ name: 'Design Two', design_id: '2', preview_url: '/images/coupon.jpg'}])
