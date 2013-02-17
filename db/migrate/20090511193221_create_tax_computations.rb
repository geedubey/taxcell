class CreateTaxComputations < ActiveRecord::Migration
  def self.up
    create_table :tax_computations do |t|
      t.decimal :section89, :precision =>16 , :scale =>2
      t.decimal :section90and91, :precision =>16 , :scale =>2
      t.decimal :rebateOnAgriInc, :precision =>16 , :scale =>2
      t.decimal :taxOnAggregateInc, :precision =>16 , :scale =>2 # virtual attribute
      t.decimal :totalTaxPayable, :precision =>16 , :scale =>2 # virtual attribute
      t.decimal :surchargeOnTaxPayable, :precision =>16 , :scale =>2 # virtual attribute
      t.decimal :educationCess, :precision =>16 , :scale =>2 # virtual attribute
      t.decimal :netTaxLiability, :precision =>16 , :scale =>2 # virtual attribute
      t.decimal :grossTaxLiability,  :precision =>16 , :scale =>2 # virtual attribute
      t.decimal :totalIntrstPay, :precision =>16 , :scale =>2 # virtual attribute 
      t.decimal :totTaxPlusIntrstPay, :precision =>16 , :scale =>2 # virtual attribute
      t.decimal :intrstPayUs234A, :precision =>16 , :scale =>2 # virtual attribute
      t.decimal :intrstPayUs234B, :precision =>16 , :scale =>2 # virtual attribute
      t.decimal :intrstPayUs234C, :precision =>16 , :scale =>2 # virtual attribute
      t.integer :form_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tax_computations
  end
end
