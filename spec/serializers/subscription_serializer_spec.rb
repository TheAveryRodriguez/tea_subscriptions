require "rails_helper"

RSpec.describe SubscriptionSerializer, type: :serializer do
  let(:subscription) { create(:subscription) }

  it "includes the expected attributes" do
    response = JSONAPI::Serializer.serialize(subscription).as_json
    expect(response["data"]["attributes"].keys).to contain_exactly("title", "price", "status", "frequency")
  end

  it "has the correct values for attributes" do
    response = JSONAPI::Serializer.serialize(subscription).as_json
    attributes = response["data"]["attributes"]
    expect(attributes["title"]).to eq(subscription.title)
    expect(attributes["price"]).to eq(subscription.price)
    expect(attributes["status"]).to eq(subscription.status)
    expect(attributes["frequency"]).to eq(subscription.frequency)
  end
end
