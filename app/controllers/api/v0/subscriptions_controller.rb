class Api::V0::SubscriptionsController < ApplicationController
  # before_action :get_customer, only: %i[index create update]
  # before_action :get_tea, only: %i[create update]

  # def index
  #   render json: SubscriptionSerializer.new(@subscription), status: 201
  # end

  # def create
  #   @subscription = @customer.subscriptions.create(subscription_params)
  #   @subscription.teas << @tea
  #   if @subscription.save
  #     render json: SubscriptionSerializer.new(@subscription), status: 201
  #   else
  #     render json: {error: @subscription.errors.full_messages}, status: :unprocessable_entity
  #   end
  # end

  # def update
  #   @subscription = Subscription.find(params[:id])
  #   @subscription.update(:status)
  #   render json: SubscriptionSerializer.new(@subscription)
  # end

  # private

  # def get_customer
  #   @customer = Customer.find(params[:customer_id])
  # end

  # def get_tea
  #   @tea = Tea.find(params[:tea_id])
  # end

  # def subscription_params
  #   params.require(:subscription).permit(:title, :price, :frequency, :customer_id, :tea_id)
  # end
end
