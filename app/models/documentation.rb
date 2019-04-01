class Documentation < ApplicationRecord
  belongs_to :machine
  mount_uploader :file, DocumentUploader
end
