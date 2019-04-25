class AddProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.timestamps
      t.string :title
      t.string :description
      t.belongs_to :owner
    end
    create_table :project_users do |t|
      t.belongs_to :user
      t.belongs_to :project
    end
    create_table :project_entries do |t|
      t.belongs_to :entry
      t.belongs_to :project
    end
  end
end
