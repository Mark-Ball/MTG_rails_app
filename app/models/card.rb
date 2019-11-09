class Card < ApplicationRecord
    has_many :listings
    has_one_attached :image

    def self.search(name)
        self.where("name LIKE ?", name)
    end
end
