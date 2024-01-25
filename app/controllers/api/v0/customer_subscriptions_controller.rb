class Api::V0::CustomerSubscriptionsController < ApplicationController
  def index
    @customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(@customer.subscriptions)
  rescue ActiveRecord::RecordNotFound => exception
    render json: {error: exception.message}
  end

  def create
    @customer_subscription = CustomerSubscription.new(subscription_id: params[:subscription_id], customer_id: params[:customer_id], status: 0)

    if @customer_subscription.save
      render json: {success: "Customer has been subscribed."}, status: :created
    else
      render json: {error: @customer_subscription.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @customer_subscription = CustomerSubscription.find_by(subscription_id: params[:subscription_id], customer_id: params[:customer_id])

    if @customer_subscription.active?
      @customer_subscription.cancelled!
      render json: {success: "Customer has been unsubscribed."}, status: 201
    else
      render json: {error: @customer_subscription.errors.full_messages}, status: :unprocessable_entity
    end
  end
end
