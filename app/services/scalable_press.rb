  require 'httmultiparty'
require 'json'
require 'yaml'

class ScalablePress
  include HTTMultiParty
  debug_output $stderr

  base_uri "https://api.scalablepress.com/v2"
  basic_auth '', SCALABLE_PRESS_APIKEY

  def create_orders
    Product.all.each do |product|
      dibs = Dib.initial.where(product_id:product.id)
      dibs.each do |dib|
        billing_detail = dib.billing_detail
        order_token = create_quote(dib, billing_detail, product.design_type, product.design_id)
        puts(order_token)
        charge = perform_charge(dib)

        if charge
          puts("CHARGE ID: #{charge.id}")
          dib.pay! charge.id
  
          order_id = create_order(order_token)
          dib.order! order_id

          puts("DIB: #{dib.inspect}")
          OrderPlacementMailer.send_order_placed_email(dib).deliver
        end
      end
    end
  end

  private

  def perform_charge(dib)
    # Get the credit card details submitted by the form
    token = dib.billing_detail.payment_token

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      Stripe::Charge.create(
        :amount => dib.product.price_in_cents,
        :currency => "usd",
        :card => token,
        :description => dib.product.description
      )
    rescue Stripe::CardError => e
      puts e  
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