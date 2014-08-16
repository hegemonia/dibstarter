require 'httmultiparty'
require 'json'

class ScalablePress
	include HTTMultiParty
	base_uri "https://api.scalablepress.com/v2"
	basic_auth '', '2ceaad81c00f173eaf11fc2412216885'

	def create_design
		@result = self.class.post("/design",
			:query => { 
				'type' => 'dtg',
				'sides[front][colors][0]' => 'white',
				'sides[front][dimensions][width]' => '5',
				'sides[front][artwork]' => File.open('/Users/Thoughtworks/Downloads/EliseSari.png')
			})

		@design_id = JSON.parse(@result.body, symbolize_names:true)[:designId])
	end
end

ScalablePress.new.create_design
