module TasksHelper

  def format_time(seconds)
    s = Integer(seconds)
    "#{s/60.floor}:#{s % 60 < 10 ? "0" : ""}#{s % 60}"
  end
end
