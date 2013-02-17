# == Schema Information
# Schema version: 20090702060743
#
# Table name: t_dsals
#
#  id                                :integer(4)      not null, primary key
#  tan                               :string(255)
#  utn                               :string(255)
#  employerOrDeductorOrCollecterName :string(255)
#  addrDetail                        :string(255)
#  cityOrTownOrDistrict              :string(255)
#  pinCode                           :integer(4)
#  stateCode                         :string(255)
#  incChrgSal                        :decimal(16, 2)
#  deductUnderChapVIA                :decimal(16, 2)
#  taxPayIncluSurchEdnCes            :decimal(16, 2)
#  totalTDSSal                       :decimal(16, 2)
#  taxPayRefund                      :decimal(16, 2)
#  tax_paid_and_refund_id            :integer(4)
#  created_at                        :datetime
#  updated_at                        :datetime
#

require 'validation_helpers'

## AOA for state code
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

class TDsal < ActiveRecord::Base

#ASSOCIATIONS
  # TaxPaidAndRefund:TDSal => 1:N
  belongs_to :tax_paid_and_refund
  
#VALIDATIONS
 
 def vdate_tdsal_amount
  
  if(incChrgSal && !vdate_is_valid_amount_range?(incChrgSal))
    errors.add(incChrgSal,'Income chargeable under the head Salaries is out of valid range.')
  end
  
  if(deductUnderChapVIA && !vdate_is_valid_amount_range?(deductUnderChapVIA))
    errors.add(deductUnderChapVIA,'Deduction under Chapter VI-A is out of valid range.')
  end
  
  if(taxPayIncluSurchEdnCes && !vdate_is_valid_amount_range?(taxPayIncluSurchEdnCes))
    errors.add(taxPayIncluSurchEdnCes,'Tax payable (incl. surch. and edn.cess) is out of valid range.')
  end
  
  if(totalTDSSal && !vdate_is_valid_amount_range?(totalTDSSal))
    errors.add(totalTDSSal,'Total tax Deducted is out of valid range.')
  end
  
  if(taxPayRefund && !vdate_is_valid_amount_range?(taxPayRefund))
    errors.add(taxPayRefund,'Salary Income is out of valid range.')
  end
  
 end

if($IsValidationOn)
  validate :vdate_tdsal_amount
  
  #TAN number
  vdate_tan(:tan)
  #UTN number
  validates_presence_of :utn , :message => "^Please fill UTN, If you do not know UTN fill '0' zero"
  #Employer Name
  vdate_name_maxlen(:employerOrDeductorOrCollecterName,75,1,"Name of Employer")  
  #Address details
  vdate_name_maxlen(:addrDetail,75,1,"Address of Employer")
  #City or TOwn of 
  vdate_name_maxlen(:cityOrTownOrDistrict,50,1,"City or Town of Employer")
  #validate pin code 
  vdate_pin(:pinCode)
  
  ## presence validation of rest mandatory fields except UTN for 09-10 and Tax payable/ refundable
  validates_presence_of :stateCode , :message => "^Please Select a State"
  validates_presence_of :incChrgSal , :message => "^Please fill Income Chargeable under Salaries"
  validates_presence_of :deductUnderChapVIA , :message => "^Please fill Deduction under chapter VI"
  validates_presence_of :taxPayIncluSurchEdnCes , :message => "^Please fill Tax Payable including surcharge"
  validates_presence_of :totalTDSSal , :message => "^Please fill Tax Deducted at Source."
 #validates_presence_of :taxPayRefund , :message => "^Please fill Tax Due or Refund."
end   
end
