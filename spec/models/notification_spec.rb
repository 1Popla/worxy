require "rails_helper"

RSpec.describe Notification, type: :model do
  let(:recipient) { create(:user) }
  let(:actor) { create(:user) }
  let(:notifiable) { create(:opinion, rater: actor, ratee: recipient) }

  let(:valid_attributes) do
    {
      recipient: recipient,
      actor: actor,
      notifiable: notifiable
    }
  end

  context "validations" do
    it "is valid with valid attributes" do
      notification = Notification.new(valid_attributes)
      expect(notification).to be_valid
    end

    it "is not valid without a recipient" do
      notification = Notification.new(valid_attributes.except(:recipient))
      expect(notification).not_to be_valid
    end

    it "is not valid without an actor" do
      notification = Notification.new(valid_attributes.except(:actor))
      expect(notification).not_to be_valid
    end

    it "is not valid without a notifiable" do
      notification = Notification.new(valid_attributes.except(:notifiable))
      expect(notification).not_to be_valid
    end
  end

  context "associations" do
    it "belongs to a recipient" do
      association = Notification.reflect_on_association(:recipient)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq("User")
    end

    it "belongs to an actor" do
      association = Notification.reflect_on_association(:actor)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq("User")
    end

    it "belongs to a notifiable" do
      association = Notification.reflect_on_association(:notifiable)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:polymorphic]).to be true
    end
  end
end
