require 'rails_helper'

describe Event, :type => :model do
  let(:event){Event.new(name: "Test", goal: 50000, ticket_price: 150)}

  describe "#completed?" do
    it "true when completed" do
      event.completed_at = Date.current
      expect(event.completed?).to be_truthy
    end

    it "false when not completed" do
      expect(event.completed?).to be_falsey
    end
  end

  describe "#avatar" do
    it "should use noimage when no avatar is present" do
      expect(event.avatar).to eq("noimage.jpg")
    end

    it "should not use noimage when avatar is present" do
      event.avatar_url="something"
      expect(event.avatar).not_to eq("noimage.jpg")
    end
  end

  describe "#completed_so_far" do
    it "should return the percentage completed" do
      expect(event.completed_so_far).to eq(50.00)
    end
  end
end
