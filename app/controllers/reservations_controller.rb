class ReservationsController < ApplicationController
  include Payload
  def load
    reservation = Reservation.load(reservation_params(params))
    render json: reservation
  end
end
