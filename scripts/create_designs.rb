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
    dimension_type = 'height'
    dimension =
      if (design['sides']['front']['dimensions']['width'].nil?)
        design['sides']['front']['dimensions']['height']
      else
        dimension_type = 'width'
        design['sides']['front']['dimensions']['width']
      end

      params = {
      'name' => design['name'],
      'type' => design['type'],
      "sides[front][dimensions][#{dimension_type}]" => dimension,
      'sides[front][placement]' => design['sides']['front']['placement'],
      'sides[front][artwork]' => File.open(File.join(PUBLIC, design['sides']['front']['artwork']))
    }

    p params

    result = self.class.post("/design", :query => params)
    if (result.code == 200)
      JSON.parse(result.body)['designId']
    else
      raise result.body
    end
  end

  def create_product(design, design_id)
    Product.create([{
      name: design['name'],
      design_type: design['type'],
      design_id: design_id,
      preview_url: design['sides']['front']['artwork'],
      color: design['color'],
      price: design['price']}])
  end

end

ScalablePress.new.create_designs
