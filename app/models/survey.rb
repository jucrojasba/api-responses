# app/models/survey.rb
class Survey < ApplicationRecord
  has_one :response, dependent: :destroy
end
