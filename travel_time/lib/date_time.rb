class DateTime
  def seconds_since_midnight
    sec + (min * 60) + (hour * 3600)
  end

  def offset_in_seconds
    (offset * 86400).to_i
  end

  def seconds_since_unix_epoch
    (jd - 2440588) * 86400 - offset_in_seconds + seconds_since_midnight
  end

  def to_f
    seconds_since_unix_epoch.to_f + sec_fraction
  end
end