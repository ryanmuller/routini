class Role < ActiveRecord::Base
  belongs_to :user
  has_many :points
end
