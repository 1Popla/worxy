require "rails_helper"

RSpec.describe Opinion, type: :model do
  let(:rater) { create(:user) }
  let(:ratee) { create(:user) }

  let(:valid_attributes) do
    {
      rater: rater,
      ratee: ratee,
      stars: 4,
      comment: "Great work!"
    }
  end

  context "validations" do
    it "is valid with valid attributes" do
      opinion = Opinion.new(valid_attributes)
      expect(opinion).to be_valid
    end

    it "is not valid without stars" do
      opinion = Opinion.new(valid_attributes.except(:stars))
      expect(opinion).not_to be_valid
    end

    it "is not valid without a comment" do
      opinion = Opinion.new(valid_attributes.except(:comment))
      expect(opinion).not_to be_valid
    end

    it "is not valid with stars less than 1" do
      opinion = Opinion.new(valid_attributes.merge(stars: 0))
      expect(opinion).not_to be_valid
    end

    it "is not valid with stars more than 5" do
      opinion = Opinion.new(valid_attributes.merge(stars: 6))
      expect(opinion).not_to be_valid
    end

    it "is not valid if the rater has already rated the ratee" do
      Opinion.create(valid_attributes)
      second_opinion = Opinion.new(valid_attributes)
      expect(second_opinion).not_to be_valid
    end
  end

  context "associations" do
    it "belongs to a rater" do
      association = Opinion.reflect_on_association(:rater)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq("User")
    end

    it "belongs to a ratee" do
      association = Opinion.reflect_on_association(:ratee)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq("User")
    end
  end
end
