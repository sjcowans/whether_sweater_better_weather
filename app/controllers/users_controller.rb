class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      @user.generate_api_key
      render json: { 
                      data: {
                              "id": @user.id,
                              "type": "users",
                              "attributes": {email: @user.email, api_key: @user.api_key}
                            }
                  }, status: 201
    else
      render json: ErrorMessageSerializer.serialize("Error: #{error_message(@user.errors)}"), status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :api_key)
  end
end