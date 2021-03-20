class Transaction < ApplicationRecord
    belongs_to :subcategory
    has_one_attached :image
end
