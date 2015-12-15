class CreateBrakemanWarnings < ActiveRecord::Migration
  def change
    create_table :brakeman_warnings do |t|
      t.integer :project_id, null: false

      t.string :warning_type, null: false
      t.integer :warning_code, null: false
      t.string :fingerprint, null: false
      t.text :message, null: false
      t.string :file, null: false
      t.integer :line
      t.string :url, null: false
      t.text :code
      t.string :confidence, null: false
      t.json :props, null: false, default: "{}"

      t.timestamps

      t.index :fingerprint, unique: true
    end
  end
end
