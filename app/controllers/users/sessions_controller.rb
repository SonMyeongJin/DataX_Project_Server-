class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  # 로그인 성공 시 응답 메서드
  def respond_with(resource, _opts = {})
    render json: {
      message: "Logged in successfully.",
      user: resource,
      token: request.env['warden-jwt_auth.token']
    }, status: :ok
  end

  # 로그아웃 시 응답 메서드
  def respond_to_on_destroy
    if current_user
      render json: { message: "Logged out successfully." }, status: :ok
    else
      render json: { message: "No active session found." }, status: :unauthorized
    end
  end
end
