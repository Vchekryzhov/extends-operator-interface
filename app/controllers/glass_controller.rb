require "redis"

class GlassController < ApplicationController
  def set
    Redis.new(db: 3).set(id, params[:glass])
  end

  def get
    render json: JSON.parse(Redis.new(db: 3).get(id).gsub("=>",":"))
  end

  private

  def id
    params[:id]
  end
end
