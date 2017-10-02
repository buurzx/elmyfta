# frozen_string_literal: true

class Product < ApplicationRecord
  extend FriendlyId

  belongs_to :organization

  validates :name, :quantity, presence: true

  friendly_id :slug_candidates, use: :slugged

  def self.all_count
    Rails.cache.fetch('prod_all_count', expires_in: 5.minutes) do
      count
    end
  end

  def slug_candidates
    [:name,
     %i[name organization_id]]
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end
