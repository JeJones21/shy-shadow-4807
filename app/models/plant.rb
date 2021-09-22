class Plant < ApplicationRecord
  has_many :plots
  has_many :inventories
  has_many :plots, through: :inventories

end
