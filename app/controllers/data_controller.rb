require "redis"

class DataController < ApplicationController

  def get
    redis = Redis.new
    data = {}
    results = JSON.parse(redis.get(id).gsub("=>",":"))
    results.each do |name, values|
      data[I18n.t(name, default: name)] = values.map{|key, value|[I18n.t(key, default: key), value]} if values
    end
    render json: {data: data.to_a}, status:200
  end

  def init_vue
    redis = Redis.new
    data = {}
    results = JSON.parse(redis.get(id).gsub("=>",":"))
    results.each do |name, values|
      data[I18n.t(name, default: name)] = values.map{|key, value|[I18n.t(key, default: key), value]} if values
    end
    render json: {data: data.to_a.map{|d| d[0]}}, status:200
  end

  def set_db
    redis = Redis.new
    collection = {}
    data_names.each do |data_name|
        collection[data_name]= params[data_name].as_json
    end
    redis.set(id, collection)
    render json: {}, status: 200
  end

  private

  def id
    params[:id]
  end

  def ids
    params[:ids]
  end

  def data_names
    params[:data_name]
  end

  def data_by_name(name)
    result = params.except(:action, :controller)
    result.delete(:id)
    result.delete(:data_name)
    result.permit!.require(name)
  end

end
