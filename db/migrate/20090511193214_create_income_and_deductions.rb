class CreateIncomeAndDeductions < ActiveRecord::Migration
  def self.up
    create_table :income_and_deductions do |t|
      t.decimal :incomeFromSal , :precision =>16 , :scale =>2
      t.decimal :famPension , :precision =>16 , :scale =>2
      t.decimal :indInterest , :precision =>16 , :scale =>2
      t.decimal :incomeFromOS , :precision =>16 , :scale =>2  # virtual attribute 
      t.decimal :grossTotIncome, :precision =>16 , :scale =>2 # virtual attribute 
      t.decimal :totalChapVIADeductions, :precision =>16 , :scale =>2 # virtual attribute  
      t.decimal :totalIncome, :precision =>16 , :scale =>2 # virtual attribute  
      t.decimal :aggregateIncome, :precision =>16 , :scale =>2 # virtual attribute  
      t.decimal :section80C , :precision =>16 , :scale =>2
      t.decimal :section80CCC, :precision =>16 , :scale =>2
      t.decimal :section80CCD, :precision =>16 , :scale =>2
      t.decimal :section80D, :precision =>16 , :scale =>2
      t.decimal :section80DD, :precision =>16 , :scale =>2
      t.decimal :section80DDB, :precision =>16 , :scale =>2
      t.decimal :section80E, :precision =>16 , :scale =>2
      t.decimal :section80G, :precision =>16 , :scale =>2
      t.decimal :section80GG, :precision =>16 , :scale =>2
      t.decimal :section80GGA, :precision =>16 , :scale =>2
      t.decimal :section80GGC, :precision =>16 , :scale =>2
      t.decimal :section80U, :precision =>16 , :scale =>2
      t.decimal :netAgriculturalIncome, :precision =>16 , :scale =>2
      t.integer :form_id

      t.timestamps
    end
  end

  def self.down
    drop_table :income_and_deductions
  end
end
