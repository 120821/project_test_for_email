json.extract! project, :id, :name, :description, :mark, :home, :is_public, :parent_project, :isInherit_Parent_Project_Members, :created_at, :updated_at
json.url project_url(project, format: :json)
