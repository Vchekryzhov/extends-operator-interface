class MachinePhotoUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  def url
    "https://eio.ksu.ru.com" + super
  end
end
