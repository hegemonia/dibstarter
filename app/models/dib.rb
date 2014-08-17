class Dib < ActiveRecord::Base
  belongs_to :billing_detail
  belongs_to :product
  belongs_to :user

  before_validation :default_values
  validates_presence_of :state, :user, :product, :billing_detail, :medium, :color, :size

  scope :initial, -> { where state: 'initial' }
  scope :ordered, -> { where state: 'ordered' }
  scope :not_initial, -> { where('state != ?', 'initial') }

  def order! order_id
    self.order_id = order_id
    self.state = 'ordered'
    save!
  end

  def pay! charge_id
    self.charge_id = charge_id
    self.state = 'payed'
    save!
  end

  private

  def default_values
    self.state ||= 'initial'
  end
end

