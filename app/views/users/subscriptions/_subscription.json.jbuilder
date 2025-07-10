json.extract! subscription, :id, :year, :student_id, :course_id, :workshop_id, :paid_amount, :household_id, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
