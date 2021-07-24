# frozen_string_literal: true

class CreateAgreements < ActiveRecord::Migration[6.1]
  def change
    create_table :agreements do |t|
      t.references :customer, null: false, foreign_key: true
      t.date :signed_date
      t.float :amount
      t.string :agreement_number
      t.references :user, null: false, foreign_key: true
      t.integer :payment_method
      t.integer :status

      # indexs
      t.index :agreement_number

      t.timestamps
    end
  end
end
