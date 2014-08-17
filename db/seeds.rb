
unless Rails.env.production?
  User.create!({:email => "test@dibstarter.com", :password => "password", :password_confirmation => "password" })
end
