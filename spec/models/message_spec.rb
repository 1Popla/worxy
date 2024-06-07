require "rails_helper"

RSpec.describe Message, type: :model do
  let(:conversation) { create(:conversation) }
  let(:user) { create(:user) }

  let(:valid_attributes) do
    {
      conversation: conversation,
      user: user,
      body: "This is a test message."
    }
  end

  context "validations" do
    it "is valid with valid attributes" do
      message = Message.new(valid_attributes)
      expect(message).to be_valid
    end

    it "is not valid without a body" do
      message = Message.new(valid_attributes.except(:body))
      expect(message).not_to be_valid
      expect(message.errors[:body]).to include("Cannot send empty message")
    end
  end

  context "associations" do
    it "belongs to a conversation" do
      association = Message.reflect_on_association(:conversation)
      expect(association.macro).to eq(:belongs_to)
    end

    it "belongs to a user" do
      association = Message.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
