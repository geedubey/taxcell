# == Schema Information
# Schema version: 20090702060743
#
# Table name: personal_infos
#
#  id                   :integer(4)      not null, primary key
#  firstName            :string(255)
#  middleName           :string(255)
#  surNameOrOrgName     :string(255)
#  pan                  :string(255)
#  residenceName        :string(255)
#  residenceNo          :string(255)
#  status               :string(255)
#  localityOrArea       :string(255)
#  roadOrStreet         :string(255)
#  dob                  :date
#  cityOrTownOrDistrict :string(255)
#  gender1              :string(255)
#  pinCode              :integer(4)
#  stateCode1           :integer(4)
#  emailAddress         :string(255)
#  employerCategory1    :string(255)
#  phoneNo              :integer(4)
#  stdCode              :integer(4)
#  form_id              :integer(4)
#  created_at           :datetime
#  updated_at           :datetime
#

require 'validation_helpers'

### for list in view
## AoA for assesment year
  INDIAN_STATES = [    
    [ "ANDAMAN & NICOBAR ISLANDS" , 1],
    [ "ANDHRA PRADESH" , 2], 
    [ "ARUNACHAL PRADESH" , 3],
    [ "ASSAM" , 4],
    [ "BIHAR" , 5],
    [ "CHANDIGARH" , 6],
    [ "DADRA AND NAGAR HAVELI" , 7],
    [ "DAMAN AND DIU" , 8],
    [ "DELHI" , 9],
    [ "GOA" , 10],
    [ "GUJARAT" , 11],
    [ "HARYANA" , 12],
    [ "HIMACHAL PRADESH" , 13],
    [ "JAMMU AND KASHMIR" , 14],
    [ "KARNATAKA" , 15],
    [ "KERALA" , 16],
    [ "LAKHSWADEEP" , 17],
    [ "MADHYA PRADESH" , 18],
    [ "MAHARASHTRA" , 19],
    [ "MANIPUR" , 20],
    [ "MEGHALAYA" , 21],
    [ "MIZORAM" , 22],
    [ "NAGALAND" , 23],
    [ "ORISSA" , 24],
    [ "PONDICHERRY" , 25],
    [ "PUNJAB" , 26],
    [ "RAJASTHAN" , 27],
    [ "SIKKIM" , 28],
    [ "TAMILNADU" , 29],
    [ "TRIPURA" , 30],
    [ "UTTAR PRADESH" , 31],
    [ "WEST BENGAL" , 32],
    [ "CHHATISHGARH" , 33],
    [ "UTTARANCHAL" , 34],
    [ "JHARKHAND" , 35],
    [ "FOREIGN" , 99]    
  ]

  ## AOR SEX
  SEX = [   
    [ "MALE" , "M"],
    [ "FEMALE" , "F"], 
   ]

  ## AOR EMPLOYER
  EMPLOYER = [   
    [ "PSU" , "PSU"],
    [ "GOV" , "GOV"],
    [ "OTH" , "OTH"],
   ]
   
   ## AOR STATUS
  STATUS = [   
    [ "INDIVIDUAL" , "I"],
    [ "HUF" , "H"] 
   ]
   
   
#TODO - validation of :status
class PersonalInfo < ActiveRecord::Base
  
  #Associations 
  # Form:PersonalInfo => 1:1
  belongs_to :form
  
  
#Validations
if($IsValidationOn)
# validation for First Name 
vdate_name_maxlen(:firstName,25,1,"First Name")

# validation for Middle name
vdate_name_maxlen(:middleName,25,0, "Second Name")  
#validates_presence_of :middleName , :message => "^Field  is not filled"

# validation for Last  name 
vdate_name_maxlen(:surNameOrOrgName,75,1, "Sur Name")

# validates PAN number
vdate_pan(:pan)

#validtaes Residence Name 
vdate_name_maxlen(:residenceName,75,0, "Residence Name")

#validates Residence Number 
vdate_name_maxlen(:residenceNo,75,1, "Residence Number")

#validate locality or area 
vdate_name_maxlen(:localityOrArea,75,1, "Locality or Area")

#validate road or street
vdate_name_maxlen(:roadOrStreet,75,0, "Road or Street")

# validate DOB : make sure that your present the form 
validates_date  :dob , :before => "01/04/2009" , :before_message => '^Ensure DoB is before %s'

#validate road or street
vdate_name_maxlen(:cityOrTownOrDistrict,75,0, "City or Town or District")

#validate Gender 
validates_presence_of :gender1 , 
                      :message => "^SEX can'be Blank"
validates_inclusion_of :gender1 , :in =>  SEX.map {|disp, value| value},
                       :message => "^Please Select Gender"
#validate pin code
vdate_pin(:pinCode)

#validate STD Code and phone number
#validates_presence_of :stdCode, :message => "^STD Code If providing mobile number fill 91 without + sign"
#validates_presence_of :phoneNo ,:message => "^Please fill Phone No"
validates_numericality_of :stdCode, :only_integer => true ,
                          :less_than_or_equal_to => 99999 ,:greater_than_or_equal_to => 0 ,
                          :if => Proc.new { |pinfo| pinfo.stdCode != nil},
                          :message => "^STD Code maximum 5 numerals allowed"
validates_numericality_of :phoneNo, :only_integer => true ,
                          :less_than_or_equal_to => 9999999999 ,:greater_than_or_equal_to => 0 ,
                          :if => Proc.new { |pinfo| pinfo.phoneNo != nil},
                          :message => "^Phone No maximum 10 numerals allowed"
#vdate_std_code_phone(:stdCode, :phoneNo)

#validate Email address 
vdate_email_address(:emailAddress)

#validate state code  - TODO - Basically make sure that input is
#coming correct from user itself 
# :stateCode1

#validate Employer Category - TODO - Again a selected list of values only 
# is posible
# :employerCategory1

#validate the foreign key 
#TODO - make sure foreign key need not be checked for duplicate entries in 
#due to non-atomic transactions . 
#vdate_foreign_key(:form_id)
end
end
