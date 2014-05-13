class Ad < ActiveRecord::Base 
  belongs_to :user
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?
  mount_uploader :pic, PicUploader
  include PgSearch
  #multisearchable :against => [:title, :description]
  pg_search_scope :search_ad, :against => [:title, :description], :using => { :tsearch => {:prefix => true}}
   
  def full_address
    [address, city, state, zip].compact.join(', ')
  end

end
