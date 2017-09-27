class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :organization

  validates :name, :quantity, presence: true

  def self.all_count
    Rails.cache.fetch('prod_all_count', expires_in: 30.minutes) do
      count
    end
  end

  def slug_candidates
    [
      :name,
      [:name, :organization_id]
    ]
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end
