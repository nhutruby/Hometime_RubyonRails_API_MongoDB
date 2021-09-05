require "rails_helper"

RSpec.describe Reservation, type: :model do
  describe "Validations" do
    before {
      @guest = Guest.create(
        first_name: "Wayne",
        last_name: "Woodbridge",
        phone: ["639123456789"],
        email: "wayne_woodbridge@bnb.com"
      )
      @reservation = Reservation.create(
        code: "YYY12345678",
        start_date: "2021-04-14",
        end_date: "2021-04-18",
        nights: 4,
        guests: 4,
        adults: 2,
        children: 2,
        infants: 0,
        status: "accepted",
        currency: "AUD",
        payout_price: "4200.00",
        security_price: "500",
        total_price: "4700.00",
        guest: @guest
      )
    }
    it "is valid with valid attributes" do
      expect(@reservation).to be_valid
    end

    it "is not valid without a code" do
      @reservation.code = nil
      expect(@reservation).to_not be_valid
    end
  end

  describe "Load data from a third party," do
    before {
      @params = {reservation: {
        code: "YYY12345678",
        start_date: "2021-04-14",
        end_date: "2021-04-18",
        nights: 4,
        guests: 4,
        adults: 2,
        children: 2,
        infants: 0,
        status: "accepted",
        currency: "AUD",
        payout_price: "4200.00",
        security_price: "500",
        total_price: "4700.00"
      }, guest: {
        first_name: "Wayne",
        last_name: "Woodbridge",
        phone: ["639123456789"],
        email: "wayne_woodbridge@bnb.com"
      }}
    }

    it "successful load" do
      load = Reservation.load(@params)
      expect(load).to eql true
    end
  end
end
