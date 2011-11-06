class Task < ActiveRecord::Base
  belongs_to :user
  has_many :logs

  validates :name, :presence => true
end
