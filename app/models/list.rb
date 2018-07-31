class List < ApplicationRecord
  acts_as_votable
  scope :not_private, -> { where(private: false) }
  serialize :movie_ids
  belongs_to :user
  validates :name, length: { minimum: 3 }
  validates :description, length: { minimum: 3 }
  validate :validate_movie_ids

  def validate_movie_ids
    if self.movie_ids[0].length<1
    errors.add(:movie_ids, :invalid)
  end
  end

end
