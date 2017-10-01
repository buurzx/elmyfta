class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name,        null: false
      t.string :inn,         null: false
      t.text   :description
      t.string :city
      t.jsonb  :info,        null: false, default: {}

      t.timestamps
    end

    add_index :organizations, :info, using: :gin
    add_index :organizations, [:inn, :name],  unique: true
  end
end
