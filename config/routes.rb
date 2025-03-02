Rails.application.routes.draw do
  # Devise 관련 경로 (API 전용)
  devise_for :users, defaults: { format: :json }, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",   # 비밀번호 재설정 (선택)
    confirmations: "users/confirmations" # 이메일 인증 (선택)
  }

  # API 전용이므로 root 경로 제거 가능
  # root "posts#index"

  # 게시글 관련 API (index, show, create, update, destroy)
  resources :posts, only: [:index, :show, :create, :update, :destroy]

  # 태그 관련 API (index, show, create, update, destroy)
  resources :tags, only: [:index, :show, :create, :update, :destroy]

  # PWA 관련 API (필요한 경우만 유지)
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
