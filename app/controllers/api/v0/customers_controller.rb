class Api::V0::CustomersController < ApplicationController
  def create
    @customer = Customer.new(customer_params)
    if @cusomter.save
      render json: CustomerSerializer.new(@customer), status: :created
    else
      render json: {error: @customer.errors.full_messages}, status: :unauthorized
    end
  end

  private

  def cusomter_params
    params.permit(:first_name, :last_name, :email, :address)
  end
end
