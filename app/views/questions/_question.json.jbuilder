json.extract! question, :id, :title, :content, :status, :level, :assigned_to, :start_day, :created_at, :updated_at
json.url question_url(question, format: :json)
