class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :body
      t.timestamp :expires_on

      t.timestamps
    end
  end
end
