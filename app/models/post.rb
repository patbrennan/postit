class Post < ActiveRecord::Base
  include Voteable # includes file because autoload_paths added in application.rb
  include Sluggable
  
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  
  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  validates :slug, uniqueness: true
  
  sluggable_column :title
end