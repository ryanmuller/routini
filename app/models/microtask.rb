class Microtask < ActiveRecord::Base
  belongs_to :task
  scope :complete, where(:status => "complete")
  scope :incomplete, where(:status => "incomplete")
  scope :updated_today, lambda { |offset| where("updated_at > ?", Time.now.utc - offset) }
  scope :created_today, lambda { |offset| where("created_at > ?", Time.now.utc - offset) }

  def self.incomplete
    where("status = ?", "incomplete")
  end
end
