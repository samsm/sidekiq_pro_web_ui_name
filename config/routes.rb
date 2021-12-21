Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # require 'sidekiq/pro/web'
  # POOL1 = ConnectionPool.new { Redis.new(:url => "redis://localhost:6379/0") }
  # mount Sidekiq::Pro::Web.with(redis_pool: POOL1), at: '/sidekiq1', as: 'sidekiq1'

  mount SidekiqDynamic => "/dynamic"
end
