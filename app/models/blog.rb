class Blog < ApplicationRecord
  belongs_to :admin
  has_many :comments
end
