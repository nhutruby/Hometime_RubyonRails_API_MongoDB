class Guest
  include Mongoid::Document
  include Mongoid::Timestamps
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :phone, type: Array

  # Validates
  validates :email, presence: true
  validates :email, uniqueness: true

  # Index
  index({email: 1}, {unique: true})

  # Association
  has_many :reservations
end
