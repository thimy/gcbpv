json.extract! course, :id, :slot_id, :instrument_id, :start_time, :end_time, :created_at, :updated_at
json.url course_url(course, format: :json)
