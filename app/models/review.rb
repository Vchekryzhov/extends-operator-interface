class Review < ApplicationRecord
  belongs_to :machine
  mount_uploader :video, VideoUploader
end
