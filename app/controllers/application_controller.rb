class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  # API 모드에서는 CSRF 검증이 필요 없음
  skip_before_action :verify_authenticity_token, raise: false

  respond_to :json

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
