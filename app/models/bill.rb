class Bill < ApplicationRecord
  belongs_to :customer
  belongs_to :type
end
