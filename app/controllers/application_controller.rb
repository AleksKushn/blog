class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include CanCan::ControllerAdditions
  before_action :authenticate


  rescue_from CanCan::AccessDenied do |e|
    render :json => {errors: [$!.to_s]}.to_json, status: :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render :json => {errors: [$!.to_s]}.to_json, :status => 422
  end


  def user_signed_in?
    current_user.present?
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" }, status: :unauthorized unless user_signed_in?
  end

  protected

  # Authenticate the user with token based authentication
  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @current_user = User.find_by(api_key: token)
    end
  end

  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def render_unauthorized(realm = "Application")
    self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
    render json: 'Bad credentials', status: :unauthorized
  end
end
