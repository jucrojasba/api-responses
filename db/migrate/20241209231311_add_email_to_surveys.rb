class AddEmailToSurveys < ActiveRecord::Migration[7.2]
  def change
    add_column :surveys, :email, :string
  end
end
