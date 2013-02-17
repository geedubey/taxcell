# == Schema Information
# Schema version: 20090522150930
#
# Table name: tax_paid_and_refunds
#
#  id                :integer(4)      not null, primary key
#  totalTaxesPaid    :decimal(16, 2)
#  balTaxPayable     :decimal(16, 2)
#  refundDue         :decimal(16, 2)
#  advanceTax        :decimal(16, 2)
#  tds               :decimal(16, 2)
#  selfAssessmentTax :decimal(16, 2)
#  bankAccountNumber :string(255)
#  ecsRequired       :string(255)
#  bankAccountType   :string(255)
#  micrCode          :string(255)
#  form_id           :integer(4)
#  created_at        :datetime
#  updated_at        :datetime
#

require 'validation_helpers'

## AOR for Account Type SAV and CUR in XSD
ACCOUNT_TYPE = [
[ "SAVINGS" , "SAV"],
[ "CURRENT" , "CUR"] 
]

## AOR for Account Type Y and N in XSD
ECS_REQD = [
[ "YES" , "Y"],
[ "NO" , "N"] 
]

class TaxPaidAndRefund < ActiveRecord::Base
  #ASSOCIATIONS
  # Form:TaxPaidAndRefund => 1:1
  belongs_to :form
  
  # TODOD - need to see how 'through' can improve the accessibility 
  # TaxPaidAndRefund:TDSal => 1:N
  has_many :t_dsals , :dependent=>:destroy # TODO - enable  when works
  
  # TaxPaidAndRefund:TDsoth => 1:N
  has_many :t_dsoths , :dependent=>:destroy # TODO - enable when works
  
  # TaxPaidAndRefund:TaxP => 1:N
  has_many :tax_ps , :dependent=>:destroy # TODO - enable when works 
  
  
  #VALIDATIONS
  if($IsValidationOn)
    # TODO - add validation for non-decimal fields too
    validate :vdate_taxpaidandrefund_amount
    
    ## Bank Acc
    validates_presence_of :bankAccountNumber , :message => "^Please Fill Bank Account No. if you want Refund" ,
                          :if => Proc.new { |taxpaidnrefund| taxpaidnrefund.refundDue && taxpaidnrefund.refundDue > 0.0 }
    validates_length_of :bankAccountNumber , :maximum => 15 , :message => "^Bank Account No can be of 15 charcater max" ,
                        :if => Proc.new { |taxpaidnrefund| taxpaidnrefund.refundDue != "" || nil }
    #validates_format_of attr , 
    #:with => /\w{1,15}/ ,
    #:message => "^Not a Proper Bank Accout No
    
    ##MICR code
    validates_presence_of :micrCode, 
                          :message => "^Please Fill MICR code if ECS is YES, It can have only numerals" ,
                          :if => Proc.new { |taxpaidnrefund| taxpaidnrefund.ecsRequired == "Y"}
    validates_format_of :micrCode ,  :with => /^\d{9}$/ , 
                        :message => "^MICR code is of exactly 9 digits" ,
                        :if => Proc.new { |taxpaidnrefund| taxpaidnrefund.ecsRequired == "Y"}
  end
  
  #validates amount input for TaxPaidAndRefund model.
  
  def vdate_taxpaidandrefund_amount
    
    if(advanceTax && !vdate_is_valid_amount_range?(advanceTax))
      errors.add(advanceTax,'AdvanceTax is out of valid range.')
    end
    
    if(tds && !vdate_is_valid_amount_range?(tds))
      errors.add(tds,'TDS is out of valid range.')
    end
    
    if(selfAssessmentTax && !vdate_is_valid_amount_range?(selfAssessmentTax))
      errors.add(selfAssessmentTax,'SelfAssessmentTax is out of valid range.')
    end
    
    if(totalTaxesPaid && !vdate_is_valid_amount_range?(totalTaxesPaid))
      errors.add(totalTaxesPaid,'TotalTaxesPaid  is out of valid range.')
    end
    
    if(balTaxPayable && !vdate_is_valid_amount_range?(balTaxPayable))
      errors.add(balTaxPayable,'BalTaxPayable is out of valid range.')
    end
    
    if(refundDue && !vdate_is_valid_amount_range?(refundDue))
      errors.add(refundDue,'RefundDue is out of valid range.')
    end    
  end
end
