# == Schema Information
# Schema version: 20090522150930
#
# Table name: airs
#
#  id            :integer(4)      not null, primary key
#  code001       :decimal(16, 2)
#  code002       :decimal(16, 2)
#  code003       :decimal(16, 2)
#  code004       :decimal(16, 2)
#  code005       :decimal(16, 2)
#  code006       :decimal(16, 2)
#  code007       :decimal(16, 2)
#  code008       :decimal(16, 2)
#  taxExmpIntInc :integer(10)
#  form_id       :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'validation_helpers'

class Air < ActiveRecord::Base
#ASSOCIATIONS
  # Form:Ver => 1:1
  belongs_to :form
  
#VALIDATIONS
  if($IsValidationOn)
    validate :vdate_air_amount
  end
  
#validates amount in AIR table
def vdate_air_amount
  if(code001 && !vdate_is_valid_amount_range?(code001))
    errors.add(code001,'Salary Income is out of valid range.')
  end
  if(code002 && !vdate_is_valid_amount_range?(code002))
    errors.add(code002,'Salary Income is out of valid range.')
  end
  if(code003 && !vdate_is_valid_amount_range?(code003))
    errors.add(code003,'Salary Income is out of valid range.')
  end
  if(code004 && !vdate_is_valid_amount_range?(code004))
    errors.add(code004,'Salary Income is out of valid range.')
  end
  if(code005 && !vdate_is_valid_amount_range?(code005))
    errors.add(code005,'Salary Income is out of valid range.')
  end
  if(code006 && !vdate_is_valid_amount_range?(code006))
    errors.add(code006,'Salary Income is out of valid range.')
  end
  if(code007 && !vdate_is_valid_amount_range?(code007))
    errors.add(code007,'Salary Income is out of valid range.')
  end
  if(code008 && !vdate_is_valid_amount_range?(code008))
    errors.add(code008,'Salary Income is out of valid range.')
  end
end
end
