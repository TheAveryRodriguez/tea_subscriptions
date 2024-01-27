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

    expect(json).to have_key(:object)
    expect(json[:object]).to be_an(Array)
    expect(json[:object].count).to eq(2)

    json[:object].each do |subscription|
      expect(subscription).to have_key(:id)
      expect(subscription[:id]).to be_a(Integer)

      expect(subscription).to have_key(:title)
      expect(subscription[:title]).to be_a(String)

      expect(subscription).to have_key(:price)
      expect(subscription[:price]).to be_a(Integer)

      expect(subscription).to have_key(:frequency)
      expect(subscription[:frequency]).to be_a(Integer)
    end
  end

  it "should return message if customer not found when looking for subscription" do
    get "/api/v0/customers/77/subscriptions"

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to eq({
      error: "Couldn't find Customer with 'id'=77"
    })
  end

  it "should return error message if customer was not successfully unsubscribed" do
    @customer_3 = Customer.create(
      first_name: "Gojo",
      last_name: "Satoru",
      email: "Gojo@gmail.com",
      address: "456 Infinite Domain, JP"
    )

    post "/api/v0/customers/#{@customer_3.id}/subscriptions/#{@subscription_1.id}"
    patch "/api/v0/customers/#{@customer_3.id}/subscriptions/#{@subscription_1.id}"
    patch "/api/v0/customers/#{@customer_3.id}/subscriptions/#{@subscription_1.id}"

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to eq({
      error: "Customer was not able to be unsubscribed."
    })
  end

  it "should return error if customr was not able to be subscribed" do
    post "/api/v0/customers/#{@customer_1.id}/subscriptions/45"

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to eq({
      error: ["Subscription must exist"]
    })
  end
end
