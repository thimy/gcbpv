json.extract! payor, :id, :last_name, :first_name, :email, :phone, :created_at, :updated_at
json.url payor_url(payor, format: :json)
