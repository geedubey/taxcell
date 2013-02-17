class CreateFilingInfos < ActiveRecord::Migration
  def self.up
    create_table :filing_infos do |t|
      t.string :desigOfficerWardorCircle
      t.integer :returnFileSec1
      t.string :returnType1
      t.date :origRetFileDate
      t.string :receiptNo
      t.string :residentialStatus1
      t.integer :form_id

      t.timestamps
    end
  end

  def self.down
    drop_table :filing_infos
  end
end
