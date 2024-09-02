class Category < ApplicationRecord
  has_many :posts

  has_many :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent_category, class_name: "Category", optional: true, foreign_key: "parent_id"

  validates :name, presence: true, uniqueness: { scope: :parent_id }
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, on: :create

  def to_param
    slug
  end

  private

  def generate_slug
    base_slug = name.parameterize
    new_slug = base_slug
    counter = 2

    while Category.exists?(slug: new_slug)
      new_slug = "#{base_slug}-#{counter}"
      counter += 1
    end

    self.slug ||= new_slug
  end
end
