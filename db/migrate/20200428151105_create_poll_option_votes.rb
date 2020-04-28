class CreatePollOptionVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :poll_option_votes do |t|
      t.references :poll_option, null: false, foreign_key: true

      t.timestamps
    end
  end
end
