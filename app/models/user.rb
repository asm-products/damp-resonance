class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_messageable
  has_many :ads, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  geocoded_by :full_address
  after_validation :geocode, :if => :zip_changed?

  def full_address
    [address, city, state, zip].compact.join(', ')
  end

  def display_name
    return "#{name}"
  end
  
  def mailboxer_email(object)
    return "{email}"
  end

end

