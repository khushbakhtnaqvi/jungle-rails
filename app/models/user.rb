class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 }, confirmation: true
  validates :password_confirmation, presence: true, length: { minimum: 5 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase) # email.strip.downcase cuts the whitespaces and corrects the case
    # If there is a user, authenticate it and return the user or nil. Else, return nil.
    user ? user.authenticate(password)? user : nil : nil
  end

end