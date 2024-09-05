json.extract! payment, :id, :payment_method, :amount, :comment
json.url payment_url(payment, format: :json)
