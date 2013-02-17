# == Schema Information
# Schema version: 20090522150930
#
# Table name: vers
#
#  id                    :integer(4)      not null, primary key
#  assesseeVerName       :string(255)
#  fatherName            :string(255)
#  place                 :string(255)
#  date                  :date
#  identificationNoOfTRP :string(255)
#  nameOfTRP             :string(255)
#  reImbFrmGov           :decimal(16, 2)
#  form_id               :integer(4)
#  created_at            :datetime
#  updated_at            :datetime
#

require 'validation_helpers'
class Ver < ActiveRecord::Base
  belongs_to :form
  
  if ($IsValidationOn)
  ## association ends
  # total fields to varify 7
  ### Field 1: validation for :assesseeVerName
  validates_presence_of :assesseeVerName , 
                        :message => "^Provide Assese name, in case Hidu Undivided Family provide Karta's name." 
  validates_length_of :assesseeVerName, :maximum => 75
#  validates_format_of :assesseeVerName, :with => /^([A-Z].+\s+)+/ ,
#                      :message => "^Full name in Block Letters"
  
  ### Field 2: validation for :fatherName
  validates_presence_of :fatherName , 
                        :message => "^Provide Father's Name" 
  validates_length_of :fatherName, :maximum => 25
  
  ### Field 3: validation for :place
  validates_presence_of :place , 
                        :message => "^Provide City Name" 
  validates_length_of :place, :maximum => 50
  
  ### Field 4: validtaion for :origRetFileDate need to change for next year
  validates_presence_of :date 
  # from plugin for 30 feb
  validates_date  :date , :after => "31/03/2009" , :after_message => '^Ensure Date is after %s'
  #would not work because date does not have size property                      
  #validates_length_of :date, :maximum => 10                       
  #validate :valid_date_for_08_09
  
  ### Field 5: validation for :identificationNoOfTRP
  #validates_presence_of :identificationNoOfTRP , 
                       # :message => "Provide City Name" 
  validates_length_of :identificationNoOfTRP, :maximum => 10 , :message => "Enter ID of TRP"
  
                      
  ### Field 6: validation for :nameOfTRP
  validates_presence_of :nameOfTRP , :if => Proc.new { |record| !record.identificationNoOfTRP.blank? }, 
                        :message => "Provide TRP Name if you are a Tax Return Preparer"
  validates_length_of :nameOfTRP, :maximum => 50 
  
  ### Field 7: validation for :reImbFrmGov
  validates_presence_of :reImbFrmGov , :if => Proc.new { |record| !record.identificationNoOfTRP.blank? }, 
                        :message => "Provide TRP commission if you are a Tax Return Preparer"
  validates_numericality_of :reImbFrmGov, :if => Proc.new { |record| !record.identificationNoOfTRP.blank? },
                            :allow_blank => true , :greater_than_or_equal_to => 0,
                            :less_than_or_equal_to => 99999999999999
  validate :vdate_reimbfromgov_amount  
  end
  
  
  private
  
  def vdate_reimbfromgov_amount
    if(reImbFrmGov && !vdate_is_valid_amount_range?(reImbFrmGov))
      errors.add(reImbFrmGov,'TRP commission amount is out of valid range.')
    end
  end

#  def valid_date_for_08_09
#    date_earliest = Date.new(2008,04,01)
#    date_latest = Date.today 
#    if (self.date != nil)
#      if (date_earliest > date) || (date > date_latest)
#        errors.add(:date, "Please select a date between on/after 1st April 2008 and today. " )
#      end
#    end
#  end  



end
