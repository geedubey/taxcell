# == Schema Information
# Schema version: 20090702060743
#
# Table name: t_dsoths
#
#  id                                :integer(4)      not null, primary key
#  tan                               :string(255)
#  utn                               :string(255)
#  employerOrDeductorOrCollecterName :string(255)
#  addrDetail                        :string(255)
#  cityOrTownOrDistrict              :string(255)
#  pinCode                           :integer(4)
#  stateCode                         :string(255)
#  amtPaid                           :decimal(16, 2)
#  datePayCred                       :date
#  totTDSOnAmtPaid                   :decimal(16, 2)
#  claimOutOfTotTDSOnAmtPaid         :decimal(16, 2)
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

class TDsoth < ActiveRecord::Base
#ASSOCIATIONS
  # TaxPaidAndRefund:TDsoth => 1:N
  belongs_to :tax_paid_and_refund
  
#VALIDATIONS
  
  
#validates TDSOth table amounts
  def vdate_tdsoth_amount
    
    if(amtPaid && !vdate_is_valid_amount_range?(amtPaid))
      errors.add(amtPaid,'Amount paid/credited is out of valid range.')
    end
    
    if(totTDSOnAmtPaid && !vdate_is_valid_amount_range?(totTDSOnAmtPaid))
      errors.add(totTDSOnAmtPaid,'Total tax Deducted is out of valid range.')
    end
    
    if(claimOutOfTotTDSOnAmtPaid && !vdate_is_valid_amount_range?(claimOutOfTotTDSOnAmtPaid))
      errors.add(claimOutOfTotTDSOnAmtPaid,'Amount out of Tax Deducted claimed for this year is out of valid range.')
    end
    
  end
  if ($IsValidationOn)
    validate :vdate_tdsoth_amount
    
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
    
    ## presence validation of rest mandatory fields except UTN for 09-10 
    validates_presence_of :stateCode , :message => "^Please Select a State"
    validates_presence_of :amtPaid , :message => "^Please fill Amount paid/credited"
    validates_presence_of :totTDSOnAmtPaid , :message => "^Please fill Total tax Deducted "
    validates_presence_of :claimOutOfTotTDSOnAmtPaid , :message => "^Please fill Amount out of Tax Deducted claimed"
    
    ## DATE of Pay or Credit
    validates_date  :datePayCred , :before => "01/04/2009", :before_message => '^Ensure Date of Payment/Credit is before %s'
  end

end
