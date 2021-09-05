require "rails_helper"

RSpec.describe Guest, type: :model do
  before { @guest = build(:guest) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(@guest).to be_valid
    end

    it "is not valid without a email" do
      @guest.email = nil
      expect(@guest).to_not be_valid
    end
  end
end
