class AddProjectIdToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :project_id, :integer
  end
end
