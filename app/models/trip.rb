class Trip < ApplicationRecord
  validates :name, :image_url, :short_description, :long_description, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }

  # Search
  scope :search, ->(query) {
    where("LOWER(name) LIKE ?", "%#{query.downcase}%") if query.present?
  }

  # Filter
  scope :min_rating, ->(rating) {
    where("rating >= ?", rating) if rating.present?
  }

  # Sort
  scope :sorted, ->(sort) {
    case sort
    when "asc" then order(rating: :asc)
    when "desc" then order(rating: :desc)
    else order(:name)
    end
  }
end