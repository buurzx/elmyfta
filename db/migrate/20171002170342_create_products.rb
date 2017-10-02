class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string     :name,     null: false
      t.integer    :quantity, default: 0
      t.string     :slug,     default: 0
      t.belongs_to :organization

      t.timestamps
    end

    add_index :products, :slug, unique: true
    add_index :products, :name
  end
end
