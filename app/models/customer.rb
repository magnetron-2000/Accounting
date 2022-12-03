class Customer < ApplicationRecord
  belongs_to :category
  validates :first_name, presence: true
  validates :second_name, presence: true
end
