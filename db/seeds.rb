
unless Rails.env.production?
  User.create!({:email => "test@dibstarter.com", :password => "password", :password_confirmation => "password" })
  User.create!({:email => "admin@dibstarter.com", :password => "password", :password_confirmation => "password", :admin => true })
end
