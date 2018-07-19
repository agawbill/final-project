class List < ApplicationRecord
  acts_as_votable
  scope :not_private, -> { where(private: false) }
  serialize :movie_ids
  belongs_to :user

end
