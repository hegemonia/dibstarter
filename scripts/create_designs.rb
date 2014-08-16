RAILS_ROOT=File.expand_path("../../", __FILE__)
PUBLIC=File.join(RAILS_ROOT, "public")

require 'httmultiparty'
require 'json'
require 'yaml'
require File.expand_path('config/environment', RAILS_ROOT)

class ScalablePress
  include HTTMultiParty
  debug_output $stderr

  base_uri "https://api.scalablepress.com/v2"
  basic_auth '', '2ceaad81c00f173eaf11fc2412216885'

  def create_designs
    designs = YAML.load(File.open("designs.yml"))
      designs.each do |design|
        design_id = create_design(design)
        puts(design_id)
        product = create_product(design, design_id)
        puts(product)
        order_token = create_quote(design['type'], design_id)
        puts("TOKEN: " + order_token)
        order_id = create_order(order_token)
        puts("ORDER ID: " + order_id)
    end
  end

  def create_design(design)
    params = {
      'name' => design['name'],
      'type' => design['type'],
      'sides[front][dimensions][width]' => design['sides']['front']['dimensions']['width'],
      'sides[front][placement]' => design['sides']['front']['placement'],
      'sides[front][artwork]' => File.open(File.join(PUBLIC, design['sides']['front']['artwork']))
    }

    result = self.class.post("/design", :query => params)

    JSON.parse(result.body)['designId']
  end

  def create_product(design, design_id)
    Product.create([{
      name: design['name'],
      design_id: design_id,
      preview_url: design['sides']['front']['artwork'],
      price: design['price']}])
  end

  def create_quote(design_type, design_id)
    params = {
      'type' => design_type,
      'sides[front]' => 1,
      'products[0][id]' => 'gildan-sweatshirt-crew',
      'products[0][color]' => 'ash',
      'products[0][size]' => 'lrg',
      'products[0][quantity]' => '12',
      'address[name]' => 'Elise McCallum',
      'address[address1]' => '193B Henry Street',
      'address[city]' => 'San Francisco',
      'address[state]' => 'CA',
      'address[zip]' => 94114,
      'designId' => design_id
    }

    result = self.class.post("/quote", :query => params)

    JSON.parse(result.body)['orderToken']
  end

  def create_order(order_token)
    params = {
      'orderToken' => order_token
    }
    result = self.class.post("/order", :query => params)
    JSON.parse(result.body)['orderId']
  end
end

ScalablePress.new.create_designs
