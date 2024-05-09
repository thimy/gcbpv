json.extract! workshop, :id, :name, :description, :city_id, :day_of_week, :frequency, :start_time, :end_time, :created_at, :updated_at
json.url workshop_url(workshop, format: :json)
