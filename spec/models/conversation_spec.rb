# spec/models/conversation_spec.rb
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }

  context "validations" do
    it "is valid with valid attributes" do
      conversation = Conversation.new(sender: user1, recipient: user2)
      expect(conversation).to be_valid
    end

    it "is not valid without a sender" do
      conversation = Conversation.new(sender: nil, recipient: user2)
      expect(conversation).not_to be_valid
    end

    it "is not valid without a recipient" do
      conversation = Conversation.new(sender: user1, recipient: nil)
      expect(conversation).not_to be_valid
    end

    it "is not valid if a conversation between the users already exists" do
      Conversation.create!(sender: user1, recipient: user2)
      duplicate_conversation = Conversation.new(sender: user1, recipient: user2)
      expect(duplicate_conversation).not_to be_valid
      expect(duplicate_conversation.errors[:base]).to include("Conversation between these users already exists")
    end
  end

  context "associations" do
    it "belongs to a sender" do
      association = Conversation.reflect_on_association(:sender)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
    end

    it "belongs to a recipient" do
      association = Conversation.reflect_on_association(:recipient)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
    end

    it "has many messages" do
      association = Conversation.reflect_on_association(:messages)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end

  context "scopes" do
    describe ".between" do
      it "returns conversations between two users" do
        conversation1 = Conversation.create!(sender: user1, recipient: user2)
        expect(Conversation.between(user1.id, user2.id)).to include(conversation1)
      end

      it "does not return conversations not involving the users" do
        conversation1 = Conversation.create!(sender: user1, recipient: user2)
        conversation3 = Conversation.create!(sender: user1, recipient: user3)
        expect(Conversation.between(user1.id, user2.id)).not_to include(conversation3)
      end
    end

    describe ".for_belonging_user" do
      it "returns conversations for a specific user" do
        conversation1 = Conversation.create!(sender: user1, recipient: user2)
        conversation3 = Conversation.create!(sender: user1, recipient: user3)
        expect(Conversation.for_belonging_user(user1.id)).to include(conversation1, conversation3)
      end

      it "does not return conversations not involving the user" do
        conversation1 = Conversation.create!(sender: user1, recipient: user2)
        conversation3 = Conversation.create!(sender: user1, recipient: user3)
        conversation4 = Conversation.create!(sender: user3, recipient: user2)
        expect(Conversation.for_belonging_user(user1.id)).not_to include(conversation4)
      end
    end
  end
end
