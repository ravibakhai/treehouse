class Property < ActiveRecord::Base
  belongs_to :user
  has_many :photos

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :property_type, presence: true
  validates :price, presence: true
  validates :accommodate, presence: true
  validates :bedroom, presence: true
  validates :bathroom, presence: true
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 500}
  validates :address, presence: true
  validates :photos, presence: true
  
end
