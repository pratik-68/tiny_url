module TimezoneHelper
  def parse_timezone(tz_param)
    return nil unless tz_param.is_a?(String)

    # Handle IANA timezone
    tz = ActiveSupport::TimeZone[tz_param]
    return tz if tz

    # Handle "Z" for UTC
    return ActiveSupport::TimeZone['UTC'] if tz_param == 'Z'

    # Handle ISO 8601 offset like "+05:30"
    match = tz_param.match(/\A([+\-\s])(\d{2}):(\d{2})\z/)
    return nil unless match

    sign = match[1] == '-' ? -1 : 1
    hours = match[2].to_i
    minutes = match[3]&.to_i
    offset_seconds = sign * (hours * 3600 + minutes * 60)

    ActiveSupport::TimeZone.all.find { |z| z.utc_offset == offset_seconds }
  end
end
