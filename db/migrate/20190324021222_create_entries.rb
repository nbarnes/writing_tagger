class CreateEntries < ActiveRecord::Migration[5.2]
  def change

    create_table :entries do |t|
      t.timestamps
      t.string :title
      t.string :description
      t.text :notes
      t.text :content
    end

  end
end
