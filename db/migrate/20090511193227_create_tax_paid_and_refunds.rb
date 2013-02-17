class CreateTaxPaidAndRefunds < ActiveRecord::Migration
  def self.up
    create_table :tax_paid_and_refunds do |t|
      t.decimal :totalTaxesPaid, :precision =>16 , :scale =>2 # virtual attribute
      t.decimal :balTaxPayable, :precision =>16 , :scale =>2 # virtual attribute
      t.decimal :refundDue, :precision =>16 , :scale =>2 # virtual attribute
      t.decimal :advanceTax, :precision =>16 , :scale =>2
      t.decimal :tds, :precision =>16 , :scale =>2
      t.decimal :selfAssessmentTax, :precision =>16 , :scale =>2
      t.string :bankAccountNumber
      t.string :ecsRequired
      t.string :bankAccountType
      t.string :micrCode
      t.integer :form_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tax_paid_and_refunds
  end
end
