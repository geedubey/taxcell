# == Schema Information
# Schema version: 20090522150930
#
# Table name: income_and_deductions
#
#  id                     :integer(4)      not null, primary key
#  incomeFromSal          :decimal(16, 2)
#  famPension             :decimal(16, 2)
#  indInterest            :decimal(16, 2)
#  incomeFromOS           :decimal(16, 2)
#  grossTotIncome         :decimal(16, 2)
#  totalChapVIADeductions :decimal(16, 2)
#  totalIncome            :decimal(16, 2)
#  aggregateIncome        :decimal(16, 2)
#  section80C             :decimal(16, 2)
#  section80CCC           :decimal(16, 2)
#  section80CCD           :decimal(16, 2)
#  section80D             :decimal(16, 2)
#  section80DD            :decimal(16, 2)
#  section80DDB           :decimal(16, 2)
#  section80E             :decimal(16, 2)
#  section80G             :decimal(16, 2)
#  section80GG            :decimal(16, 2)
#  section80GGA           :decimal(16, 2)
#  section80GGC           :decimal(16, 2)
#  section80U             :decimal(16, 2)
#  netAgriculturalIncome  :decimal(16, 2)
#  form_id                :integer(4)
#  created_at             :datetime
#  updated_at             :datetime
#

require 'validation_helpers'

class IncomeAndDeduction < ActiveRecord::Base
# ASSOCIATIONS 
  # Form:IncomeAndDeduction => 1:1
  belongs_to :form

  # VALIDATIONS
  if($IsValidationOn)
    validate :vdate_amount
  end
  
# A common function to do the validation for the model.
def vdate_amount
  
  if(incomeFromSal && !vdate_is_valid_amount_range?(incomeFromSal))
    errors.add(incomeFromSal,'Salary Income is out of valid range.')
  end
  
  if(famPension  && !vdate_is_valid_amount_range?(famPension))
      errors.add(famPension,'Family Pension is out of valid range.')
  end

  if(indInterest  && !vdate_is_valid_amount_range?(indInterest))
      errors.add(indInterest,'Income from Interest  is out of valid range.')
  end
  
  if(incomeFromOS  && !vdate_is_valid_amount_range?(incomeFromOS))
      errors.add(incomeFromOS,'Income from other source is out of valid range.')
  end
  
  if(grossTotIncome  && !vdate_is_valid_amount_range?(grossTotIncome))
      errors.add(grossTotIncome,'Gross Total Income is out of valid range.')
  end

  if(section80C  && !vdate_is_valid_amount_range?(section80C))
      errors.add(section80C,'Section80C Savings is out of valid range.')
  end
  
  if(section80CCC && !vdate_is_valid_amount_range?(section80CCC)) 
      errors.add(section80CCC,'section80CCC Savings is out of valid range.')
  end

if(section80CCD && !vdate_is_valid_amount_range?(section80CCD)) 
    errors.add(section80CCD,'section80CCD Savings is out of valid range.')
end

if(section80D && !vdate_is_valid_amount_range?(section80D)) 
    errors.add(section80D,'Section80D savings is out of valid range.')
end

if(section80DD && !vdate_is_valid_amount_range?(section80DD)) 
    errors.add(section80DD,'Section80DD savings is out of valid range.')
end

if(section80DDB && !vdate_is_valid_amount_range?(section80DDB)) 
    errors.add(section80DDB,'section80DDB Savings is out of valid range.')
end

if(section80E && !vdate_is_valid_amount_range?(section80E)) 
    errors.add(section80E,'section80E savings is out of valid range.')
end

if(section80G && !vdate_is_valid_amount_range?(section80G)) 
    errors.add(section80G,'section80G savings is out of valid range.')
end

if(section80GG && !vdate_is_valid_amount_range?(section80GG)) 
    errors.add(section80GG,'section80GG savings is out of valid range.')
end

if(section80GGA && !vdate_is_valid_amount_range?(section80GGA)) 
    errors.add(section80GGA,'section80GGA savings is out of valid range.')
end

if(section80GGC && !vdate_is_valid_amount_range?(section80GGC)) 
    errors.add(section80GGC,'section80GGC savings is out of valid range.')
end

if(section80U && !vdate_is_valid_amount_range?(section80U)) 
    errors.add(section80U,'section80U savings is out of valid range.')
end

if(section80U && !vdate_is_valid_amount_range?(section80U)) 
    errors.add(section80U,'section80U savings is out of valid range.')
end

if(totalChapVIADeductions && !vdate_is_valid_amount_range?(totalChapVIADeductions)) 
    errors.add(totalChapVIADeductions,'Total savings under Chapater VI  is out of valid range.')
end

if(totalIncome && !vdate_is_valid_amount_range?(totalIncome)) 
    errors.add(totalIncome,'Total Income Income is out of valid range.')
end 

if(netAgriculturalIncome && !vdate_is_valid_amount_range?(netAgriculturalIncome)) 
    errors.add(netAgriculturalIncome,'Net Agricultural Income Income is out of valid range.')
end  

if(aggregateIncome && !vdate_is_valid_amount_range?(aggregateIncome)) 
    errors.add(aggregateIncome,'Aggregate Income is out of valid range.')
end

end # end of the custom validation functions

end # end of the class definition
