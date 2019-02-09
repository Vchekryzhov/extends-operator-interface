require "redis"

class InfoController < ApplicationController
  def show
    redis = Redis.new
    @data = redis.get(id)
  end

  private

  def id
    params[:id]
  end
end
