class User < ApplicationRecord
  # Devise 모듈 포함
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  # posts와의 관계 설정 (사용자가 삭제되면 해당 사용자의 게시글도 삭제됨)
  has_many :posts, dependent: :destroy

  # jti 자동 생성
  before_create :set_jti

  private

  def set_jti
    self.jti = SecureRandom.uuid if jti.blank?
  end
end
