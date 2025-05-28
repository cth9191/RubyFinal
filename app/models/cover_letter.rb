class CoverLetter < ApplicationRecord
  validates :user_name, presence: true, length: { minimum: 2 }
  validates :company_name, presence: true, length: { minimum: 2 }
  validates :role, presence: true, length: { minimum: 2 }
  validates :extra_info, length: { maximum: 1000 }
end
