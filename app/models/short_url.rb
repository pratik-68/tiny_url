class ShortUrl < ApplicationRecord
  # Scopes
  #-----------------------------------------------------------------------------
  scope :active, -> { where(is_active: true) }

  # Associations
  #-----------------------------------------------------------------------------
  has_many :clicks, dependent: :destroy

  # Validations
  #-----------------------------------------------------------------------------
  validates :original_url, presence: true
  validates :short_code, presence: true, uniqueness: true

  # Callbacks
  #-----------------------------------------------------------------------------
  before_validation :generate_short_code, on: :create


  def generate_short_code
    return if short_code.present?
    loop do
      self.short_code = SecureRandom.alphanumeric(6)
      break unless ShortUrl.exists?(short_code: short_code)
    end
  end
end
