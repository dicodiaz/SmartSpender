class User < ApplicationRecord
  has_many :categories
  has_many :purchases, foreign_key: 'author_id'
end
