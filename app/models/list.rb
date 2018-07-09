class List < ApplicationRecord
  scope :not_private, -> { where(private: false) }
  serialize :movie_ids
  belongs_to :user
end
