
unless Rails.env.production?
  User.create!({:email => "test@dibstarter.com", :password => "password", :password_confirmation => "password" })
end

products = Product.create([{ name: 'Design One', design_id: '1', preview_url: '/images/EliseSari.png'},
	{ name: 'Design Two', design_id: '2', preview_url: '/images/EliseSari.png'}])
