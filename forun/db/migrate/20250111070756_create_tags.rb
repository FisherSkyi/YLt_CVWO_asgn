class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false

      t.timestamps
    end

    # Add a unique index to the name column
    add_index :tags, :name, unique: true
  end
end
