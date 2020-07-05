class User < ActiveRecord::Base
    has_secure_password
    attr_accessor :entered_password, :password_confirm
end