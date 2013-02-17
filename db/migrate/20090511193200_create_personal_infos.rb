class CreatePersonalInfos < ActiveRecord::Migration
  def self.up
    create_table :personal_infos do |t|
      t.string :firstName
      t.string :middleName
      t.string :surNameOrOrgName
      t.string :pan
      t.string :residenceName
      t.string :residenceNo
      t.string :status
      t.string :localityOrArea
      t.string :roadOrStreet
      t.date :dob
      t.string :cityOrTownOrDistrict
      t.string :gender1
      t.integer :pinCode
      t.integer :stateCode1
      t.string :emailAddress
      t.string :employerCategory1
      t.integer :phoneNo
      t.integer :stdCode
      t.integer :form_id

      t.timestamps
    end
  end

  def self.down
    drop_table :personal_infos
  end
end
