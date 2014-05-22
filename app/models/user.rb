class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_messageable
  has_many :ads, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  geocoded_by :full_address
  reverse_geocoded_by :latitude, :longitude, :address => :full_address
  after_validation :geocode, :reverse_geocode :if => :address_changed?

  def self.find_for_facebook_oauth(auth)
  where(auth.slice(:provider, :uid)).first_or_create do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
  end
end  

  def display_name
    return "#{name}"
  end

  def full_address
    [address, city, state, zip].compact.join(', ')
  end

  def mailboxer_email(object)
    return "{email}"
  end

end

