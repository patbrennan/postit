class CreatePostsCategories < ActiveRecord::Migration
  def change
    create_table :posts_categories do |t|
      t.references :post, index: true
      t.references :category, index: true
    end
  end
end
