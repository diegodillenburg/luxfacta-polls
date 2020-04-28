class CreatePollOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :poll_options do |t|
      t.string :option_description

      t.references :poll, null: false, foreign_key: true

      t.timestamps
    end
  end
end
