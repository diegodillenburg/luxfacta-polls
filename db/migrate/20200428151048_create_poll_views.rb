class CreatePollViews < ActiveRecord::Migration[6.0]
  def change
    create_table :poll_views do |t|
      t.references :poll, null: false, foreign_key: true

      t.timestamps
    end
  end
end
