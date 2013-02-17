class CreateVers < ActiveRecord::Migration
  def self.up
    create_table :vers do |t|
      t.string :assesseeVerName
      t.string :fatherName
      t.string :place
      t.date :date
      t.string :identificationNoOfTRP
      t.string :nameOfTRP
      t.decimal :reImbFrmGov, :precision =>16 , :scale =>2
      t.integer :form_id

      t.timestamps
    end
  end

  def self.down
    drop_table :vers
  end
end
