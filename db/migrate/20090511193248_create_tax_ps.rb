class CreateTaxPs < ActiveRecord::Migration
  def self.up
    create_table :tax_ps do |t|
      t.string :nameOfBank
      t.string :nameOfBranch
      t.integer :bsrCode
      t.date :dateDep
      t.integer :srlNoOfChaln
      t.decimal :amt, :precision =>16 , :scale =>2
      t.integer :tax_paid_and_refund_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tax_ps
  end
end
