class Dib < ActiveRecord::Base
  belongs_to :billing_detail
  belongs_to :product
  belongs_to :user

  before_validation :default_values
  validates_presence_of :state, :user, :product, :billing_detail, :medium, :color, :size

  private

  def default_values
    self.state ||= 'initial'
  end
end

