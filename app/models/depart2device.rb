class Depart2device < ApplicationRecord
  belongs_to :device
  belongs_to :department
end
