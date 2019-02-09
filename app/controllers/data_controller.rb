require "redis"

class DataController < ApplicationController

  def set
    redis = Redis.new
    redis.set(id, data)
    render json: {}, status: 200
  end

  def get
    redis = Redis.new
    result = redis.get(id)
    data = JSON.parse(result.gsub("=>",":")).map{|key, value|[key, value]} if result
    render json: {data: data}, status:200
  end

  private

  def id
    params[:id]
  end

  def data
    result = params.except(:action, :controller)
    result.delete(:id)
    result.permit!
  end

end
