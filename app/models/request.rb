class Request < ApplicationRecord
  # searchkick
  # after_create :create_inputs
  def create_inputs
    request["inputs"].map do |i|
        Input.create(
          device_id: i['device_id'],
          group_input_id: i['group_id'],
          value: i['value'] || i['values'],
          client_time: created_at,
          name: i['name'],
          request_id: id
        )
    end if request["inputs"].present?
  end
end
