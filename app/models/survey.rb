class Survey < ApplicationRecord
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_one :response, dependent: :destroy
end
