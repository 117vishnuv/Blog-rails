class User < ApplicationRecord
  #adding username also to login
  attr_writer :login

  def login
    @login || self.username || self.email
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
          authentication_keys: [:login]
  
  # only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  
  #validation for user name
  validates :username, presence: true, uniqueness: { case_sensitive: true }

  #this extends Devise to query via warden. This uses some SQL- 
  #to query for either the username or email fields given one or- 
  #the other is supplied during form submission.
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
