class Property < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :reviews

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :property_type, presence: true
  validates :price, presence: true
  validates :accommodate, presence: true
  # validates :bedroom, presence: true
  validates :bathroom, presence: true
  validates :listing_name, presence: true, length: {maximum: 1000}
  validates :summary, presence: true, length: {maximum: 2000}
  validates :address, presence: true

  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end

  def show_first_photo(size)
    if self.photos.length == 0
      "treehouselogo.png"
    else
      self.photos[0].image.url(size)
    end
  end

end
