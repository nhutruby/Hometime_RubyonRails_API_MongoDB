class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps
  field :code, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  field :payout_price, type: BigDecimal
  field :localized_description, type: String
  field :adults, type: Integer
  field :children, type: Integer
  field :infants, type: Integer
  field :status, type: String
  field :security_price, type: BigDecimal
  field :currency, type: String
  field :nights, type: Integer
  field :total_price, type: BigDecimal
  field :guests, type: Integer

  # Validates
  validates :code, presence: true
  validates :code, uniqueness: true

  # Index
  index({code: 1}, {unique: true})

  # Association
  belongs_to :guest

  def self.load(params)
    reservation = params[:reservation]
    guest = params[:guest]
    if reservation[:code].present? && guest[:email].present?
      new_guest = Guest.create_with(first_name: guest[:first_name],
        last_name: guest[:last_name]).find_or_create_by(email: guest[:email])
      new_reservation = Reservation.create_with(guest: new_guest,
        start_date: reservation[:start_date], end_date: reservation[:end_date],
        payout_price: reservation[:payout_price],
        localized_description: reservation[:localized_description],
        adults: reservation[:adults], children: reservation[:children],
        infants: reservation[:infants], status: reservation[:status],
        security_price: reservation[:security_price], currency: reservation[:currency],
        nights: reservation[:nights], total_price: reservation[:total_price],
        guests: reservation[:guests]).find_or_create_by(code: reservation[:code])
      new_reservation.save
    end
  end
end
