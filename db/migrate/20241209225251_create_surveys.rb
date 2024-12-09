class CreateSurveys < ActiveRecord::Migration[7.2]
  def change
    create_table :surveys do |t|
      t.string :name
      t.text :description
      t.boolean :processed_in_job

      t.timestamps
    end
  end
end
