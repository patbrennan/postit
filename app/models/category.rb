class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories
  
  validates :name, presence: true, uniqueness: true, length: {minimum: 2}
  
  before_save :generate_slug!
  
  def generate_slug!
    return if self.slug
    
    new_slug = to_slug(self.name)
    last_char = new_slug[-1]
    
    while Category.find_by(slug: new_slug)
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