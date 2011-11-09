class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  belongs_to :task

  def self.first_day
    first.created_at.to_date
  end

  def self.from_day(day)
    where("created_at > ? AND created_at < ?", day, day + 1.days) 
  end

  def self.plot_data(user, roles)
    range = [Time.now.to_date - first_day, 100].min
    data = []

    roles.each do |role|
      roledata = []
      (0..range).each do |i|
        roledata << [i, where("user_id = ? AND role_id = ?", user.id, role.id).from_day(first_day + i).sum("points")]
      end
      data << { :label => role.name, :data => roledata }
    end

    return data
  end

  def self.plot_data_stacked(user, roles)
    range = [Time.now.to_date - first_day, 100].min
    data = []

    roles.each_with_index do |role, j|
      roledata = []
      
      (0..range).each do |i|
        pts = where("user_id = ? AND role_id = ?", user.id, role.id).from_day(first_day + i).sum("points")
        if j == 0
          roledata << [i, pts]
        else 
          roledata << [i, pts + data[j-1][:data][i][1] ]
        end
      end
      data << { :label => role.name, :data => roledata }
    end

    return data

  end
end
