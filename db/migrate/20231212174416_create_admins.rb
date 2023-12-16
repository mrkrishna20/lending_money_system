class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :name
      t.float :wallet, default: 1000000.0

      t.timestamps
    end
  end
end
