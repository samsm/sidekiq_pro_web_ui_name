class SidekiqDynamic < ::Rails::Engine
  def self.webs
    to_activate_for_web = ["default"]
    redis_hash = {
      "default" => "redis://localhost:6379/0"
    }
    @webs ||= to_activate_for_web.each_with_object({}) do |redis_name, collection|
      redis_url = redis_hash[redis_name]
      pool = ConnectionPool.new do
        Redis.new(:url => redis_url)
      end

      web = Sidekiq::Pro::Web.with(redis_pool: pool)

      # web.define_singleton_method(:name) { "SidekiqProWebFor--#{redis_name}" }

      collection[redis_name] = web
    end
  end
end

SidekiqDynamic.routes.draw do
  require 'sidekiq/pro/web'
  SidekiqDynamic.webs.each_pair do |name, web|
    mount web, at: "/#{name}"
  end
end
