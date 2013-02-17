class CreateTDsals < ActiveRecord::Migration
  def self.up
    create_table :t_dsals do |t|
      t.string :tan
      t.string :utn
      t.string :employerOrDeductorOrCollecterName
      t.string :addrDetail
      t.string :cityOrTownOrDistrict
      t.integer :pinCode
      t.string :stateCode
      t.decimal :incChrgSal, :precision =>16 , :scale =>2
      t.decimal :deductUnderChapVIA, :precision =>16 , :scale =>2
      t.decimal :taxPayIncluSurchEdnCes, :precision =>16 , :scale =>2
      t.decimal :totalTDSSal, :precision =>16 , :scale =>2
      t.decimal :taxPayRefund, :precision =>16 , :scale =>2
      t.integer :tax_paid_and_refund_id 

      t.timestamps
    end
  end

  def self.down
    drop_table :t_dsals
  end
end
