class ReservationsController < ApplicationController
  include Payload
  def load
    reservation = Reservation.load(parse_params)
    render json: reservation
  end

  private

  def parse_params
    if params[:payload][:reservation_code].present? && params[:payload][:guest] && params[:payload][:guest][:email].present?
      checked_params = params.require(:payload).permit(:reservation_code, :start_date,
        :end_date, :nights, :guests,
        :adults, :children, :infants, :status,
        :currency, :payout_price, :security_price, :total_price,
        guest: [:first_name, :last_name, :phone, :email])
      get_params_version_1(checked_params)
    elsif params[:payload][:reservation] && params[:payload][:reservation][:code].present? && params[:payload][:reservation][:guest_email].present?
      checked_params = params.require(:payload).permit(reservation: [:code, :start_date,
        :end_date, :expected_payout_amount,
        :guest_email, :guest_first_name, :guest_last_name,
        :listing_security_price_accurate,
        :host_currency, :nights, :number_of_guests,
        :status_type, :total_paid_amount_accurate,
        guest_details: [:localized_description,
          :number_of_adults, :number_of_children,
          :number_of_infants], guest_phone_numbers: []])
      get_params_version_2(checked_params[:reservation])
    else
      {reservation: nil, guest: nil}
    end
  end
end
