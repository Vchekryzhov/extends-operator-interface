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

  def analytic
    date_from = ''
    results = ActiveRecord::Base.connection.execute("
    SELECT
            ABS(SUM(extract(epoch from  (src1.created_at - src1.prev_created_at)) / 60)) work_time,
            src1.chan1_status
    FROM (
            SELECT  src.machine_id,
                    src.chan1_mode,
                    src.chan1_status,
                    src.created_at,
                    lead(src.chan1_mode) over(PARTITION BY src.machine_id ORDER BY src.created_at) next_chan1_mode,
                    lead(src.chan1_status) over(PARTITION BY src.machine_id ORDER BY src.created_at) next_chan1_status,
                    lead(src.created_at) over(PARTITION BY src.machine_id ORDER BY src.created_at) prev_created_at
             FROM
    (SELECT  md.machine_id,
            md.data->'chan1'->'chan1_entries.cur_chanmode' chan1_mode,
            md.data->'chan1'->'chan1_entries.cur_chanstatus' chan1_status,
            md.created_at
    FROM machine_data md
    WHERE md.machine_id = #{params[:id].to_i}
          AND md.created_at > date('#{Date.today.to_s(:db)}')) src ) src1
    GROUP BY src1.machine_id, src1.chan1_mode, src1.chan1_status;
    ")
    labels = []
    values = []
    results.each do |r|
      labels.push(r['chan1_status'])
      values.push(r['work_time'])
    end
    render json: {labels: labels, values: values}
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
    Redis.new(db: 1).set(id, Time.current)
    render json: {}, status: 200
  end

  def set_db_with_history
    redis = Redis.new
    collection = {}
    data_names.each do |data_name|
        collection[data_name]= params[data_name].as_json
    end
    redis.set(id, collection)
    MachineDatum.create(machine_id: id, data: collection)
    Redis.new(db: 1).set(id, Time.current)
    render json: {}, status: 200
  end

  def v2_set_db_with_history
    Request.create(request: params[:datum])
    render json: {}, status: 200
  end

  def v2_get
    render json: Request.where('request @> ?', {id: params[:id].to_i}.to_json)&.last&.request
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
