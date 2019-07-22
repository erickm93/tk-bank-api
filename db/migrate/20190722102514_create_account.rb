class CreateAccount < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true, null: false
      t.monetize :balance

      t.timestamps
    end

    change_column :accounts, :balance_cents, :integer, limit: 8
  end
end
