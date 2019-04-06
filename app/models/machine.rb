class Machine < ApplicationRecord
  mount_uploader :image, MachinePhotoUploader
  has_many :documentations
  extend Enumerize

  enumerize :machine_type, in: [:milling, :turn, :stand, :other]

  def custom_label_method
    "#{title} #{model} #{machine_type}"
  end
end
