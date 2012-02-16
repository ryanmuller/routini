class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  belongs_to :task

  def self.first_day
    first.created_at.to_date
  end

  def self.from_time(time, user)
    time_offset = user.time_offset || 0
    day = time.to_date
    if time < day + time_offset.hours
      where("created_at > ? AND created_at < ?", day - 1.days + time_offset.hours, day + time_offset.hours) 
    else
      where("created_at > ? AND created_at < ?", day + time_offset.hours, day + 1.days + time_offset.hours) 
    end
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
    data = []


    roles.each_with_index do |role, j|
      roledata = [[0,0]]
      i = 0
      if user.points.empty?
        reset_time = 0
      else
        reset_time = user.points.first.created_at.to_date + user.time_offset.hours

      # add up points from each
      where("user_id = ? AND role_id = ?", user.id, role.id).each do |pt|
        reset_time ||= pt.created_at.to_date + user.time_offset.hours

        while reset_time < pt.created_at
          i += 1
          roledata << [i, 0]
          reset_time += 1.day
        end
        
        roledata.last[1] += pt.points
      end
      
      # fill in zeros until today
      while reset_time < Time.now.utc
        i += 1
        roledata << [i, 0]
        reset_time += 1.day
      end

      # add totals from before to make stack
      if j > 0
        roledata.each_with_index do |rd, i|
          rd[1] += data[j-1][:data][i][1]
        end
      end


      data << { :label => role.name, :data => roledata }
    end

      
'''
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
'''

    return data.reverse
  end
end
