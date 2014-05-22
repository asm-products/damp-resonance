class Ad < ActiveRecord::Base
  belongs_to :user
  geocoded_by :zip
  after_validation :geocode, :if => :zip_changed?
  mount_uploader :pic, PicUploader
  mount_uploader :pic2, Pic2Uploader
  include PgSearch
  #multisearchable :against => [:title, :description]
  pg_search_scope :search_ad, :against => [:title, :description], :using => { :tsearch => {:prefix => true}}
   
  def full_address
    [address, city, state, zip].compact.join(', ')
  end

end
