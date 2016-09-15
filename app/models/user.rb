class User < ActiveRecord::Base

  def self.authenticate(email, password)
    @user= User.where(email: email, password: password).first
    if !@user.nil?
      return @user
    else
      return nil
    end
  end
end
