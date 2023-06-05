class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.string :status
      t.string :level
      t.string :assigned_to
      t.datetime :start_day

      t.timestamps
    end
  end
end
