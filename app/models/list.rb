class List < ApplicationRecord
  serialize :movie_ids
  belongs_to :user
end
