class Product < ActiveRecord::Base
  def dibbed? user
    Dib.where(user_id: user.id, product_id: self.id).first.present?
  end
end
