class Click < ApplicationRecord
  # Associations
  #-----------------------------------------------------------------------------
  belongs_to :short_url

  # Validations
  #-----------------------------------------------------------------------------
  validates :clicked_at, presence: true
end
