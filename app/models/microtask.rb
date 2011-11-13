class Microtask < ActiveRecord::Base
  belongs_to :task

  def self.incomplete
    where("status = ?", "incomplete")
  end
end
