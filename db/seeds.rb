
unless Rails.env.production?
  User.create!({:email => "test@dibstarter.com", :password => "password", :password_confirmation => "password" })
end

products = Product.create([{ name: 'Design One', design_id: '1', design_type: 'dtg', preview_url: '/images/EliseSari.png', price: '20.00'},
	{ name: 'Design Two', design_id: '2', design_type: 'dtg', preview_url: '/images/EliseSari.png', price: '15.00'}])
