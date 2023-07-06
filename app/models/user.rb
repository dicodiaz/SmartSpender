class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  has_many :categories, dependent: :destroy
  has_many :purchases, foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true
end
