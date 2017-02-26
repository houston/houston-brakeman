class ReindexedBrakemanWarnings < ActiveRecord::Migration[5.0]
  def up
    remove_index :brakeman_warnings, :fingerprint
    add_index :brakeman_warnings, [:project_id, :fingerprint], unique: true
  end

  def down
    remove_index :brakeman_warnings, [:project_id, :fingerprint]
    remove_index :brakeman_warnings, :fingerprint, unique: true
  end
end
