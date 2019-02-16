require "redis"

class DataController < ApplicationController

  def get
    redis = Redis.new
    data = []
    ids.each do |id_data|
          result = redis.get(id_data)
          data.push JSON.parse(result.gsub("=>",":")).map{|key, value|[key, value]} if result
    end
    render json: {data: data}, status:200
  end

  def set_db
    redis = Redis.new
    data_names.each do |data_name|
        redis.set("#{data_name}_#{id}", data_by_name(data_name))
    end
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
