class Machine < ApplicationRecord
  mount_uploader :image, MachinePhotoUploader
  has_many :documentations
  has_many :machine_datum
  extend Enumerize

  enumerize :machine_type, in: [:milling, :turn, :stand, :other]

  def custom_label_method
    "#{title} #{model} #{machine_type}"
  end

  def last_online
    Time.parse(Redis.new(db: 1).get(id)) if Redis.new(db: 1).get(id)
  end
  
  def online?
    Redis.new(db: 1).get(id) && Time.parse(Redis.new(db: 1).get(id)) > Time.current - 3.seconds
  end
end
