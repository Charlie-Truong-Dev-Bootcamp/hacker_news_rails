class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password
  validates_presence_of :password, :on => :create
end
