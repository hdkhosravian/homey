class CreateStatusChanges < ActiveRecord::Migration[7.2]
  def change
    create_table :status_changes do |t|
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
