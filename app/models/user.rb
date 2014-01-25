class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :full_name, :login, :user_name, :password, :password_confirmation, :remember_me
  attr_accessor :login
  
  validates :user_name,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }
  
  has_many :tweets, :dependent => :destroy
  has_many :followers
  has_many :followings, :class_name => "Follower", :foreign_key	=> "follower_id"
  
  def login=(login)
    @login = login
  end

  def login
    @login || self.user_name || self.email
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["user_name = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end
  
end
