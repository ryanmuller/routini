class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  belongs_to :task

  def self.first_day
    first.created_at.to_date
  end

  def self.from_day(day)
    time_offset = user.time_offset || 0
    day = day.to_date.to_time.utc
    where("created_at > ? AND created_at < ?", day + time_offset, day + 1.days + time_offset) 
  end

  def self.plot_data(user, roles)
    range = [Time.now.to_date - first_day, 14].min
    data = []

    roles.each do |role|
      roledata = []
      (0..range).each do |i|
        roledata << [i, where("user_id = ? AND role_id = ?", user.id, role.id).from_day(Time.now.to_date - (range - i).days).sum("points")]
      end
      data << { :label => role.name, :data => roledata }
    end

    return data
  end

  def self.plot_data_stacked(user, roles)
    range = Time.now.to_date - first_day
    data = []


    roles.each_with_index do |role, j|
      roledata = []
      i = -1
      last_pt = nil
      reset_time = nil

      where("user_id => ? AND role_id = ?", user.id, role.id).each do |pt|
        last_pt ||= pt
        reset_time = last_pt.created_at.to_date.to_utc + time_offset

        if i == -1 or (reset_time < pt.created_at)
          i += 1
          roledata << [i, pt.points]
        else
          roledata.last += pt.points
        end

        last_pt = pt
      end

      # add totals from before to make stack
      if j > 0
        roledata.each_with_index do |rd, i|
          roledata[i] += data[j-1][:data][i][1]
        end
      end

      data << { :label => role.name, :data => roledata }

      

      (0..range).each do |i|
        pts = where("user_id = ? AND role_id = ?", user.id, role.id).from_day(Time.now.to_date - (range - i).days).sum("points")
        if j == 0
          roledata << [i, pts]
        else 
          roledata << [i, pts + data[j-1][:data][i][1] ]
        end
      end
      data << { :label => role.name, :data => roledata }
    end

    return data.reverse

  end
end
