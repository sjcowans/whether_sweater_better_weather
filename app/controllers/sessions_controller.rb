class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      render json: { 
                      data: {
                              "id": @user.id,
                              "type": "users",
                              "attributes": @user
                            }
                    }, status: 201
    else
      render json: ErrorMessageSerializer.serialize("Error: Invalid email or password."), status: 401
    end
  end
end