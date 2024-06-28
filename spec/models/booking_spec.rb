require 'rails_helper'

RSpec.describe Booking, type: :model do
  let(:booking) { create(:booking) }

  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a visible_to_user (optional)' do
      association = described_class.reflect_on_association(:visible_to_user)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:class_name]).to eq 'User'
      expect(association.options[:optional]).to be true
    end
  end

  describe 'validations' do
    it 'validates presence of start_date' do
      booking.start_date = nil
      booking.valid?
      expect(booking.errors[:start_date]).to include("can't be blank")
    end

    it 'validates presence of end_date' do
      booking.end_date = nil
      booking.valid?
      expect(booking.errors[:end_date]).to include("can't be blank")
    end

    it 'validates end_date is after start_date' do
      booking.end_date = booking.start_date - 1.day
      booking.valid?
      expect(booking.errors[:end_date]).to include("must be after the start date")
    end
  end

  describe 'enum status' do
    it 'defines enum for status' do
      expect(Booking.statuses).to eq({'pending' => 0, 'confirmed' => 1, 'completed' => 2, 'cancelled' => 3})
    end
  end
end