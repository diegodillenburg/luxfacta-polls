class CreatePolls < ActiveRecord::Migration[6.0]
  def change
    create_table :polls do |t|
      t.string :poll_description

      t.timestamps
    end
  end
end
