# == Schema Information
# Schema version: 20090522150930
#
# Table name: forms
#
#  id         :integer(4)      not null, primary key
#  formName   :string(255)
#  formType   :string(255)
#  year       :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Form < ActiveRecord::Base
  #Every form must have an associated user User:Form is 1:N
  belongs_to :user

  # Form:PersonalInfo => 1:1
  has_one :personal_info, :dependent=>:destroy
  
  # Form:FilingInfo => 1:1
  has_one :filing_info, :dependent=>:destroy
  
  # Form:IncomeAndDeduction => 1:1
  has_one :income_and_deduction, :dependent=>:destroy
  
  # Form:TaxComputation => 1:1
  has_one :tax_computation, :dependent=>:destroy
  
  # Form:TaxPaidAndRefund => 1:1
  # TODO - need to see how 'through' can improve the accessibility 
  # for tables TDsal, TDsoth and Taxp
  # TODO - need to add the the same action in :tax_paid_and_refund model also 
  # that will automatically delete taxp/tdsal/tdsoth
  has_one :tax_paid_and_refund, :dependent=>:destroy
  
  # Form:Air => 1:1
  has_one :air, :dependent=>:destroy
  
  # Form:Ver => 1:1
  has_one :ver, :dependent=>:destroy
  
  #### associations end
  
  ## AoA for form type
  FORM_TYPES = [
    [ "ITR1-Individuals having Income from Salary" , "ITR1"]    
  ]
  ## AoA for assesment year
  ASSESMENT_YEARS = [    
    [ "2009-10" , "2009-10"]    
  ]
  # total fields to varify 3
  ### Field 1: validation for :formName
  validates_presence_of :formName , :message => "^Field Form Name, Fill any name to later remember the ITR form" 
  validates_length_of :formName, :maximum => 20
  
  ### Field 2: validation for :formType see AoA FORM_TYPES
  validates_presence_of :formType , :message => "^Plesae Select Any ITR Form Type form drop-down list"
  validates_inclusion_of :formType , :in => FORM_TYPES.map {|disp, value| value},
                         :message => "^Plesae Select Any ITR Form Type from drop-down list"
  
  ### Field 3: validation for :year see AoA FORM_TYPES
  validates_presence_of :year , :message => "^Plesae Select Any ITR Form Type form drop-down list"
  validates_inclusion_of :year, :in =>  ASSESMENT_YEARS.map {|disp, value| value},
                         :message => "^Plesae Select Assesment Year from drop-down list"
  validates_exclusion_of :year, :in => %w{ 2010-11},
                         :message => "^Select 2009-10 from year list"
                         
 ## BL
  
end
