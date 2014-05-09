class Ad < ActiveRecord::Base 
  belongs_to :user
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?
  mount_uploader :pic, PicUploader

  def full_address
    [address, city, state, zip].compact.join(', ')
  end

end
