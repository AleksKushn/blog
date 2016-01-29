class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_with_token!, only: [:update, :destroy]
  load_and_authorize_resource
  # GET /users
  def index
    @users = User.all

    render :json => @users.to_json(), status: 200
  end

  # GET /users/1
  def show
    render json: @user.to_json(), status: 200
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    user = current_user
    if user.update(user_params)
      render :json => user.to_json(), status: 200
    else
      render  :json => { errors: [$!.to_s] }.to_json, :status => 422
    end
  end

  # DELETE /users/1
  def destroy
    current_user.destroy
    head 204
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
