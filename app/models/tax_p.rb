# == Schema Information
# Schema version: 20090702060743
#
# Table name: tax_ps
#
#  id                     :integer(4)      not null, primary key
#  nameOfBank             :string(255)
#  nameOfBranch           :string(255)
#  bsrCode                :integer(4)
#  dateDep                :date
#  srlNoOfChaln           :integer(4)
#  amt                    :decimal(16, 2)
#  tax_paid_and_refund_id :integer(4)
#  created_at             :datetime
#  updated_at             :datetime
#

require 'validation_helpers'


class TaxP < ActiveRecord::Base
  # TaxPaidAndRefund:TaxP => 1:N
  belongs_to :tax_paid_and_refund

#VALIDATIONS
  
  def vdate_taxp_amount
    if(amt && !vdate_is_valid_amount_range?(amt))
      errors.add(amt,'Amount is out of valid range.')
    end
  end
  
  if ($IsValidationOn)
    validate :vdate_taxp_amount
    
    #name of Bank
    vdate_name_maxlen(:nameOfBank,25,1,"Name of Bank")
    #branch of Bank
    vdate_name_maxlen(:nameOfBranch,25,1,"Branch of Bank")
    #BSR Code
    validates_presence_of :bsrCode , :message => "^Please Fill BSR Code"
    validates_format_of :bsrCode ,  :with => /^\d{7}$/ ,
    :message => "^invalid BSR Code, BSR is 7 digit number"
    #Date of Deposit
    validates_date :dateDep , :message => "Date of Deposit is not proper"
    #Serial Number of Challan
    validates_presence_of :srlNoOfChaln , :message => "^Please Fill Challan Number"
    validates_format_of :srlNoOfChaln ,  :with => /^\d{5}$/ ,
    :message => "^invalid Challan Number, Challan number is 5 digit number"                
    # presence of Amnt field
    validates_presence_of :amt , :message => "^Please fill Amount"
  end
  
end
