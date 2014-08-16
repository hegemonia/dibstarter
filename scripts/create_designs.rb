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
end

ScalablePress.new.create_designs
