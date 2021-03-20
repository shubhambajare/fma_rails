json.extract! transaction, :id, :subcategory_id, :description, :amount, :img_url, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
