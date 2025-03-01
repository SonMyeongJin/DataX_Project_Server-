Rails.application.routes.draw do
  # Devise의 기본 컨트롤러를 오버라이드하여 JSON 응답을 반환하도록 설정
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  # 기본 루트 설정 (로그인 후 게시글 목록 페이지로 이동)
  root "posts#index"

  # 게시글 관련 경로 (index, show, create, update, destroy)
  resources :posts, only: [:index, :show, :create, :update, :destroy]

  # Health check 및 PWA 파일 제공
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
