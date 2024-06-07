require "rails_helper"

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }

  describe "associations" do
    it "belongs to a user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it "belongs to a category" do
      association = described_class.reflect_on_association(:category)
      expect(association.macro).to eq :belongs_to
    end

    it "has many bookings" do
      association = described_class.reflect_on_association(:bookings)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it "has many attached images" do
      expect(post.images).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end

  describe "validations" do
    it "validates presence of title" do
      post.title = nil
      post.valid?
      expect(post.errors[:title]).to include("can't be blank")
    end

    it "validates presence of description" do
      post.description = nil
      post.valid?
      expect(post.errors[:description]).to include("can't be blank")
    end

    it "validates presence of price" do
      post.price = nil
      post.valid?
      expect(post.errors[:price]).to include("can't be blank")
    end

    it "validates presence of category_id" do
      post.category_id = nil
      post.valid?
      expect(post.errors[:category_id]).to include("can't be blank")
    end
  end

  describe "enum status" do
    it "defines enum for status" do
      expect(Post.statuses).to eq({"draft" => 0, "pending" => 1, "active" => 2, "archived" => 3})
    end
  end

  describe "geocoding" do
    it "geocodes address after validation if address changed" do
      allow(post).to receive(:geocode)
      post.update(street: "123 Main St", city: "Anytown", state: "CA", country: "USA")
      post.valid?
      expect(post).to have_received(:geocode)
    end

    it "does not geocode address if address did not change" do
      allow(post).to receive(:geocode)
      post.valid?
      expect(post).not_to have_received(:geocode)
    end
  end

  describe "#address" do
    it "returns the full address" do
      post.update(street: "123 Main St", city: "Anytown", state: "CA", country: "USA")
      expect(post.address).to eq("123 Main St, Anytown, CA, USA")
    end

    it "returns a partial address if some parts are missing" do
      post.update(city: "Anytown", country: "USA")
      expect(post.address).to eq("Anytown, USA")
    end
  end

  it "returns false if no address fields have changed" do
    post.update(title: "New Title")
    expect(post.address_changed?).to be false
  end
end
