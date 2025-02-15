class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :user, null: true, foreign_key: true # we deferred the application of authentication system

      t.timestamps
    end
  end
end
