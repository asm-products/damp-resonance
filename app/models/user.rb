class User < ActiveRecord::Base
 has_one :facebook_oauth_setting
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_messageable
  has_many :ads, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?

  

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

