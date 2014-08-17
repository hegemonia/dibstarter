RAILS_ROOT=File.expand_path("../../", __FILE__)
PUBLIC=File.join(RAILS_ROOT, "public")

require 'httmultiparty'
require 'json'
require 'yaml'
require File.expand_path('config/environment', RAILS_ROOT)

class ScalablePress
  include HTTMultiParty

  base_uri "https://api.scalablepress.com/v2"
  basic_auth '', '2ceaad81c00f173eaf11fc2412216885'

  def create_orders
    Product.all.each do |product|
      dibs = Dib.initial.where(product_id:product.id)
      dibs.each do |dib|
        billing_detail = dib.billing_detail
        order_token = create_quote(dib, billing_detail, product.design_type, product.design_id)
        puts(order_token)
        order_id = create_order(order_token)
        puts("ORDER ID: " + order_id)
        dib.order!
        puts("DIB STATE: " + dib.state)
      end
    end
  end

  def create_quote(dib, billing_detail, design_type, design_id)
    params = {
      'type' => design_type,
      'sides[front]' => 1,
      'products[0][id]' => dib.medium,
      'products[0][color]' => dib.color,
      'products[0][size]' => dib.size,
      'products[0][quantity]' => '1',
      'address[name]' => billing_detail.name,
      'address[address1]' => billing_detail.address1,
      'address[address2]' => billing_detail.address2,
      'address[city]' => billing_detail.city,
      'address[state]' => billing_detail.state,
      'address[zip]' => billing_detail.zip,
      'designId' => design_id
    }

    result = self.class.post("/quote", :query => params)
    if (result.code == 200) 
      JSON.parse(result.body)['orderToken']
    else
      raise result.body
    end
  end

  def create_order(order_token)
    params = {
      'orderToken' => order_token
    }
    result = self.class.post("/order", :query => params)
    if (result.code == 200)
      JSON.parse(result.body)['orderId']
    else
      raise result.body
    end
  end
end

ScalablePress.new.create_orders