class Idea < ApplicationRecord

    has_many :reviews, dependent: :destroy
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user
    has_many :joins, dependent: :destroy
    has_many :joiners, through: :joins, source: :user

    validates(:title, presence: true, uniqueness: true)

    validates :description, presence: { message: "must exist"}

end