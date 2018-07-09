class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :blogs, dependent: :destroy
  has_many :comments
  has_many :lists
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
