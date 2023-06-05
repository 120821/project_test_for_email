class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :mark
      t.string :home
      t.boolean :is_public
      t.integer :parent_project
      t.boolean :isInherit_Parent_Project_Members

      t.timestamps
    end
  end
end
