class CreateBrakemanScansWarnings < ActiveRecord::Migration
  def change
    create_table :brakeman_scans_warnings, id: false do |t|
      t.references :scan, :warning
    end
  end
end
