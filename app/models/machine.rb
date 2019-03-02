class Machine < ApplicationRecord
  mount_uploader :image, MachinePhotoUploader
  extend Enumerize

  enumerize :machine_type, in: [:milling, :turn, :other]
end
