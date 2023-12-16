class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|
      t.float :amount
      t.float :interest_rate, default: 5.0
      t.integer :state, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
