require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'associations' do
    it 'has many conversations' do
      association = described_class.reflect_on_association(:conversations)
      expect(association.macro).to eq :has_many
      expect(association.options[:foreign_key]).to eq :sender_id
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many messages' do
      association = described_class.reflect_on_association(:messages)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many bookings' do
      association = described_class.reflect_on_association(:bookings)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many booked_services through posts' do
      association = described_class.reflect_on_association(:booked_services)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :posts
      expect(association.options[:source]).to eq :bookings
    end

    it 'has many sent_notifications' do
      association = described_class.reflect_on_association(:sent_notifications)
      expect(association.macro).to eq :has_many
      expect(association.options[:class_name]).to eq 'Notification'
      expect(association.options[:foreign_key]).to eq :actor_id
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many received_notifications' do
      association = described_class.reflect_on_association(:received_notifications)
      expect(association.macro).to eq :has_many
      expect(association.options[:class_name]).to eq 'Notification'
      expect(association.options[:foreign_key]).to eq :recipient_id
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many given_opinions' do
      association = described_class.reflect_on_association(:given_opinions)
      expect(association.macro).to eq :has_many
      expect(association.options[:class_name]).to eq 'Opinion'
      expect(association.options[:foreign_key]).to eq :rater_id
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many received_opinions' do
      association = described_class.reflect_on_association(:received_opinions)
      expect(association.macro).to eq :has_many
      expect(association.options[:class_name]).to eq 'Opinion'
      expect(association.options[:foreign_key]).to eq :ratee_id
      expect(association.options[:dependent]).to eq :destroy
    end
  end

  describe 'validations' do
    it 'validates presence of first_name' do
      user.first_name = nil
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it 'validates presence of last_name' do
      user.last_name = nil
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'validates presence of role' do
      user.role = nil
      user.valid?
      expect(user.errors[:role]).to include("can't be blank")
    end

    it 'validates presence of phone_number' do
      user.phone_number = nil
      user.valid?
      expect(user.errors[:phone_number]).to include("can't be blank")
    end

    it 'validates length of phone_number' do
      user.phone_number = '123'
      user.valid?
      expect(user.errors[:phone_number]).to include("is too short (minimum is 9 characters)")
    end

    it 'validates presence of country_code' do
      user.country_code = nil
      user.valid?
      expect(user.errors[:country_code]).to include("can't be blank")
    end
  end

  describe '#average_rating' do
    before do
      @user = create(:user)
    end

    context 'when there are no received opinions' do
      it 'returns nil' do
        expect(@user.average_rating).to be_nil
      end
    end
  end
end