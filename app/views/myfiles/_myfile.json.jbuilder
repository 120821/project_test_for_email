json.extract! myfile, :id, :name, :text, :created_at, :updated_at
json.url myfile_url(myfile, format: :json)
