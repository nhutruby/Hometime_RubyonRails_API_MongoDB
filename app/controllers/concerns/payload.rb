# frozen_string_literal: true

# Authenticable model
module Payload
  extend ActiveSupport::Concern

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