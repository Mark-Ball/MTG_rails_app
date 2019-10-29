class Card < ApplicationRecord
    has_many :listings
    has_one_attached :image
end
