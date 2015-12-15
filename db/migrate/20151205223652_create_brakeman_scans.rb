class CreateBrakemanScans < ActiveRecord::Migration
  def change
    create_table :brakeman_scans do |t|
      t.integer :project_id, null: false
      t.integer :commit_id
      t.string :sha, null: false

      t.string :brakeman_version
      t.integer :duration
      t.string :checks_performed, array: true
    end
  end
end
