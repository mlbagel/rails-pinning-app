class User < ActiveRecord::Base

  has_secure_password
  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email

  has_many :boards
  has_many :pinnings, dependent: :destroy
  has_many :pins, through: :pinnings,  dependent: :destroy



  def self.authenticate(email, password)
   @user = User.find_by_email(email)

   if !@user.nil?
     if @user.authenticate(password)
       return @user
     end
   end

   return nil
 end
end
