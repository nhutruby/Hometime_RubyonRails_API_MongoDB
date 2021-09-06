# frozen_string_literal: true

# Authenticable model
module Payload
  extend ActiveSupport::Concern

  private

  def reservation_params(params)
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
  def get_params_version_1(params)
    guest = {}
    guest[:first_name] = params[:guest][:first_name]
    guest[:last_name] = params[:guest][:last_name]
    guest[:phone] = [params[:guest][:phone]]
    guest[:email] = params[:guest][:email]
    reservation = {}
    reservation[:code] = params[:reservation_code]
    reservation[:start_date] = params[:start_date]
    reservation[:end_date] = params[:end_date]
    reservation[:nights] = params[:nights]
    reservation[:guests] = params[:guests]
    reservation[:adults] = params[:adults]
    reservation[:children] = params[:children]
    reservation[:infants] = params[:infants]
    reservation[:status] = params[:status]
    reservation[:currency] = params[:currency]
    reservation[:payout_price] = params[:payout_price]
    reservation[:security_price] = params[:security_price]
    reservation[:total_price] = params[:total_price]
    {guest: guest, reservation: reservation}
  end

  def get_params_version_2(params)
    guest = {}
    guest[:first_name] = params[:guest_first_name]
    guest[:last_name] = params[:guest_last_name]
    guest[:phone] = params[:guest_phone_numbers]
    guest[:email] = params[:guest_email]
    reservation = {}
    reservation[:code] = params[:code]
    reservation[:start_date] = params[:start_date]
    reservation[:end_date] = params[:end_date]
    reservation[:nights] = params[:nights]
    reservation[:guests] = params[:number_of_guests]
    if params[:guest_details]
      reservation[:adults] = params[:guest_details][:number_of_adults]
      reservation[:children] = params[:guest_details][:number_of_children]
      reservation[:infants] = params[:guest_details][:number_of_infants]
      reservation[:localized_description] = params[:guest_details][:localized_description]
    end
    reservation[:status] = params[:status_type]
    reservation[:currency] = params[:host_currency]
    reservation[:payout_price] = params[:expected_payout_amount]
    reservation[:security_price] = params[:listing_security_price_accurate]
    reservation[:total_price] = params[:total_paid_amount_accurate]
    {guest: guest, reservation: reservation}
  end
end