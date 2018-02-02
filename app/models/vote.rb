class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true
  
  # validate an association based on a scope. Allows a user to only vote once.
  validates_uniqueness_of :user, scope: :voteable
end