class Ad < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  geocoded_by :zip
  reverse_geocoded_by :latitude, :longitude do |obj, results|
   if geo = results.first
   obj.city = geo.city
   obj.state = geo.state
   end
  end
  after_validation :geocode, :if => :zip_changed?
  after_validation :fetch_address
  mount_uploader :pic, PicUploader
  mount_uploader :pic2, Pic2Uploader
  mount_uploader :pic3, Pic3Uploader
  monetize :price_cents
 
  def self.nearest(user, distance)
     near(user, distance)
  end
 
  def full_address
    [address, city, state, zip].compact.join(', ')
  end

end
