class CreateTDsoths < ActiveRecord::Migration
  def self.up
    create_table :t_dsoths do |t|
      t.string :tan
      t.string :utn
      t.string :employerOrDeductorOrCollecterName
      t.string :addrDetail
      t.string :cityOrTownOrDistrict
      t.integer :pinCode
      t.string :stateCode
# removing the column directly It is already present in TDSal table - vipin
#     t.decimal :incChrgSal, :precision =>16 , :scale =>2 
      t.decimal :amtPaid, :precision =>16 , :scale =>2
      t.date :datePayCred
      t.decimal :totTDSOnAmtPaid, :precision =>16 , :scale =>2
      t.decimal :claimOutOfTotTDSOnAmtPaid, :precision =>16 , :scale =>2
      t.integer :tax_paid_and_refund_id

      t.timestamps
    end
  end

  def self.down
    drop_table :t_dsoths
  end
end
