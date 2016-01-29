class SessionsController < ApplicationController
  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user&& user.authenticate(user_password)
      sign_in user, store: false
      render :json => {:api_key => user.api_key, :login => user.login}, :status => 200
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    user = User.find_by(api_key: params[:id])
    head 204
  end
end
