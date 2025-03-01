class User < ApplicationRecord
  # Devise 모듈 포함
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # posts와의 관계 설정 (사용자가 삭제되면 해당 사용자의 게시글도 삭제됨)
  has_many :posts, dependent: :destroy
end
