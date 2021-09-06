class ReservationsController < ApplicationController
  include Payload
  def load
    reservation = Reservation.load(parse_params)
    render json: reservation
  end

  private

  def parse_params
    reservation_params(params)
  end
end
