class Task < ActiveRecord::Base
  belongs_to :user
  has_many :logs
  has_many :points

  validates :name, :presence => true
end
