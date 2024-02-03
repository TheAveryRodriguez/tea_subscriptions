# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

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
