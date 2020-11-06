class CreateSights < ActiveRecord::Migration[6.0]
  def change
    create_table :sights do |t|
      t.references :place, null: false, foreign_key: true
      t.string :activity_type, mull: false

      t.timestamps
    end
  end
end
