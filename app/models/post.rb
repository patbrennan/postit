class Post < ActiveRecord::Base
  include Voteable # able to pick up file because autoload_paths added in application.rb
  
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  
  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  validates :slug, uniqueness: true
  
  before_save :generate_slug!
  
  def generate_slug!
    return if self.slug
    
    new_slug = to_slug(self.title)
    last_char = new_slug[-1]
    
    while Post.find_by(slug: new_slug)
      if last_char.to_i == 0
        new_slug += "-" + (last_char.to_i + 1).to_s
      else
        next_num = last_char.to_i + 1
        new_slug[-1] = next_num.to_s
      end
    end
    self.slug = new_slug
  end
  
  def to_slug(name)
    slugged = name.gsub(/[\s[^a-zA-Z0-9]]/, "-")
    slugged.gsub!(/-{2,}/, "-")
    slugged.gsub!(/\A-+|-+\z/, "")
    slugged.downcase
  end
  
  def to_param
    self.slug
  end
end