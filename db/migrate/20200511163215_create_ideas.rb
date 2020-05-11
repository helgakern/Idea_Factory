class CreateIdeas < ActiveRecord::Migration[6.0]

  def change
    create_table :ideas do |t|

      t.string :title # This creates a VARCHAR (255) column named title
      t.text :description 

      t.timestamps
    end
    # add_reference :ideas, :user, null: true, foreign_key: true
  end
end