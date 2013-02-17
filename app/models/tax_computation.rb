# == Schema Information
# Schema version: 20090702060743
#
# Table name: tax_computations
#
#  id                    :integer(4)      not null, primary key
#  section89             :decimal(16, 2)
#  section90and91        :decimal(16, 2)
#  rebateOnAgriInc       :decimal(16, 2)
#  taxOnAggregateInc     :decimal(16, 2)
#  totalTaxPayable       :decimal(16, 2)
#  surchargeOnTaxPayable :decimal(16, 2)
#  educationCess         :decimal(16, 2)
#  netTaxLiability       :decimal(16, 2)
#  grossTaxLiability     :decimal(16, 2)
#  totalIntrstPay        :decimal(16, 2)
#  totTaxPlusIntrstPay   :decimal(16, 2)
#  intrstPayUs234A       :decimal(16, 2)
#  intrstPayUs234B       :decimal(16, 2)
#  intrstPayUs234C       :decimal(16, 2)
#  form_id               :integer(4)
#  created_at            :datetime
#  updated_at            :datetime
#

require 'validation_helpers'

class TaxComputation < ActiveRecord::Base
# ASSOCIATIONS
  # Form:TaxComputation => 1:1
  belongs_to :form

  #VALIDATIONS
  if($IsValidationOn)
    validate :vdate_taxcomputation_amount
  end

#validates all the amount related inputs for the TaxComputation Model.
def vdate_taxcomputation_amount
  
  if(taxOnAggregateInc && !vdate_is_valid_amount_range?(taxOnAggregateInc))
    errors.add(taxOnAggregateInc,'Tax Payable on Aggregate Income is out of valid range.')
  end
  
  if(rebateOnAgriInc && !vdate_is_valid_amount_range?(rebateOnAgriInc))
    errors.add(rebateOnAgriInc,'Rebate on Net Agricultural Income is out of valid range.')
  end
  
  if(totalTaxPayable && !vdate_is_valid_amount_range?(totalTaxPayable))
    errors.add(totalTaxPayable,'Total Tax Payable is out of valid range.')
  end
  
  if(surchargeOnTaxPayable && !vdate_is_valid_amount_range?(surchargeOnTaxPayable))
    errors.add(surchargeOnTaxPayable,'SurCharge on Total Tax is out of valid range.')
  end
  
  if(educationCess && !vdate_is_valid_amount_range?(educationCess))
    errors.add(educationCess,'Education Cess is out of valid range.')
  end
  
  if(grossTaxLiability && !vdate_is_valid_amount_range?(grossTaxLiability))
    errors.add(grossTaxLiability,'Gross Tax Liability is out of valid range.')
  end
  
  if(section89 && !vdate_is_valid_amount_range?(section89))
    errors.add(section89,'Relief under Section 89 is out of valid range.')
  end
  
  if(section90and91 && !vdate_is_valid_amount_range?(section90and91))
    errors.add(section90and91,'Relief under Section 90/91 is out of valid range.')
  end
  
  if(netTaxLiability && !vdate_is_valid_amount_range?(netTaxLiability))
    errors.add(netTaxLiability,'Net Tax Liability is out of valid range.')
  end
  
  if(intrstPayUs234A && !vdate_is_valid_amount_range?(intrstPayUs234A))
    errors.add(intrstPayUs234A,'Interest Payable u/s 234A  is out of valid range.')
  end
  
  if(intrstPayUs234B && !vdate_is_valid_amount_range?(intrstPayUs234B))
    errors.add(intrstPayUs234A,'Interest Payable u/s 234B  is out of valid range.')
  end
  
  if(intrstPayUs234C && !vdate_is_valid_amount_range?(intrstPayUs234C))
    errors.add(intrstPayUs234C,'Interest Payable u/s 234C  is out of valid range.')
  end
  
  if(totalIntrstPay && !vdate_is_valid_amount_range?(totalIntrstPay))
    errors.add(totalIntrstPay,'Total Interest Payable u/s 234  is out of valid range.')
  end    
  
  if(totTaxPlusIntrstPay && !vdate_is_valid_amount_range?(totTaxPlusIntrstPay))
    errors.add(totTaxPlusIntrstPay,'Tatal Tax and Interest on delayed tax is out of valid range.')
  end  
  
end


end
