class CreateAirs < ActiveRecord::Migration
  def self.up
    create_table :airs do |t|
      t.decimal :code001, :precision =>16 , :scale =>2
      t.decimal :code002, :precision =>16 , :scale =>2
      t.decimal :code003, :precision =>16 , :scale =>2
      t.decimal :code004, :precision =>16 , :scale =>2
      t.decimal :code005, :precision =>16 , :scale =>2
      t.decimal :code006, :precision =>16 , :scale =>2
      t.decimal :code007, :precision =>16 , :scale =>2
      t.decimal :code008, :precision =>16 , :scale =>2
      t.decimal :taxExmpIntInc, :precision =>16 , :scale =>2
      t.integer :form_id

      t.timestamps
    end
  end

  def self.down
    drop_table :airs
  end
end
