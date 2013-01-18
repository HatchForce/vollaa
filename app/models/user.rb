class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_one :profile
  has_many :saved_properties, :through => :properties
  after_create :after_signup

  def after_signup

  @k = Profile.create({:user_id => self.id})
  end

  def self.create_with_omniauth_twitter(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth.info.name rescue "na"
      user.image = auth["info"]["image"] rescue "na"
      user.email = auth["user_info"]["email"] rescue "na"
      user.oauth_token = auth.params.oauth_token rescue ''
      user.save(:validate => false)   rescue 'na'
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name  rescue ''
      user.email = auth.info.email  rescue ''
      user.image = auth.info.image   rescue ''
      user.location = auth.info.location rescue ''
      user.oauth_token = auth.credentials.token  rescue ''
      user.oauth_expires_at = Time.at(auth.credentials.expires_at) rescue ''
      user.save(:validate => false)   rescue ''
    end
    end

end
