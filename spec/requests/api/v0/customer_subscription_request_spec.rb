require "rails_helper"

RSpec.describe "Customer Subscription Request" do
  before(:each) do
    @customer_1 = Customer.create(
      first_name: "Yuji",
      last_name: "Itadori",
      email: "Yuji@gmail.com",
      address: "123 Jujutsu High Lane, JP"
    )

    @tea_1 = Tea.create(
      title: "Black",
      description: "Dark and mysterious",
      temperature: 100,
      brew_time: 60
    )

    @tea_2 = Tea.create(
      title: "Green",
      description: "Earthy and herbacious",
      temperature: 156,
      brew_time: 150
    )

    @tea_3 = Tea.create(
      title: "White",
      description: "Light and fruity",
      temperature: 212,
      brew_time: 300
    )

    @subscription_1 = Subscription.create(
      title: "Weekly Subscription",
      price: 10,
      status: 0,
      frequency: 7
    )

    @subscription_2 = Subscription.create(
      title: "Monthly Subscription",
      price: 40,
      status: 0,
      frequency: 30
    )

    TeaSubscription.create(subscription_id: @subscription_1.id, tea_id: @tea_1.id)
    TeaSubscription.create(subscription_id: @subscription_1.id, tea_id: @tea_2.id)

    TeaSubscription.create(subscription_id: @subscription_2.id, tea_id: @tea_2.id)
    TeaSubscription.create(subscription_id: @subscription_2.id, tea_id: @tea_3.id)
  end

  it "sends message showing that a customer has subscribed successfully to a tea subscription" do
    post "/api/v0/customers/#{@customer_1.id}/subscriptions/#{@subscription_1.id}"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to eq({success: "Customer has been subscribed."})

    expect(@customer_1.subscriptions.count).to eq(1)
    expect(@customer_1.subscriptions.first).to be_a(Subscription)
    expect(@customer_1.subscriptions.first.title).to eq("Weekly Subscription")
    expect(@customer_1.subscriptions.first.price).to eq(10)
    expect(@customer_1.subscriptions.first.frequency).to eq(7)
    expect(@customer_1.customer_subscriptions.first.status).to eq("active")
  end

  it "sends message showing that customer has been sucessfully unsubscribed from a tea subscription" do
    post "/api/v0/customers/#{@customer_1.id}/subscriptions/#{@subscription_1.id}"
    patch "/api/v0/customers/#{@customer_1.id}/subscriptions/#{@subscription_1.id}"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to eq({success: "Customer has been unsubscribed."})

    expect(@customer_1.subscriptions.count).to eq(1)
    expect(@customer_1.subscriptions.first).to be_a(Subscription)
    expect(@customer_1.subscriptions.first.title).to eq("Weekly Subscription")
    expect(@customer_1.subscriptions.first.price).to eq(10)
    expect(@customer_1.subscriptions.first.frequency).to eq(7)
    expect(@customer_1.customer_subscriptions.first.status).to eq("cancelled")
  end

  it "should return all of a customer's subscriptions, both active and cancelled" do
    post "/api/v0/customers/#{@customer_1.id}/subscriptions/#{@subscription_1.id}"
    post "/api/v0/customers/#{@customer_1.id}/subscriptions/#{@subscription_2.id}"
    get "/api/v0/customers/#{@customer_1.id}/subscriptions"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:data)
    expect(json[:data]).to be_an(Array)
    expect(json[:data].count).to eq(2)

    json[:data].each do |subscription|
      expect(subscription).to have_key(:id)
      expect(subscription[:id]).to be_a(String)

      expect(subscription).to have_key(:type)
      expect(subscription[:type]).to eq("subscription")

      expect(subscription).to have_key(:attributes)
      expect(subscription[:attributes]).to be_a(Hash)

      expect(subscription[:attributes]).to have_key(:title)
      expect(subscription[:attributes][:title]).to be_a(String)

      expect(subscription[:attributes]).to have_key(:price)
      expect(subscription[:attributes][:price]).to be_a(Float)

      expect(subscription[:attributes]).to have_key(:frequency)
      expect(subscription[:attributes][:frequency]).to be_a(String)
    end
  end

  xit "should return message if customer not found when looking for subscription" do
    get "/api/v0/customers/77/subscriptions"

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to eq({
      error: "Couldn't find Customer with 'id'=77"
    })
  end

  xit "sould return error message if customer was not successfully unsubscribed" do
    patch "/api/v0/customers/56/subscriptions/#{@subscription.id}"

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to eq({
      error: "Customer was not able to be unsubscribed. Please make sure the customer or subscription id is correct."
    })
  end

  xit "should return error if customr was not able to be subscribed" do
    post "/api/v0/customers/#{@customer_1.id}/subscriptions/45"

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to eq({
      error: "Customer was not able to be subscribed. Please make sure the customer or subscription id is correct."
    })
  end
end
