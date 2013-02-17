# == Schema Information
# Schema version: 20090522150930
#
# Table name: filing_infos
#
#  id                       :integer(4)      not null, primary key
#  desigOfficerWardorCircle :string(255)
#  returnFileSec1           :integer(4)
#  returnType1              :string(255)
#  origRetFileDate          :date
#  receiptNo                :string(255)
#  residentialStatus1       :string(255)
#  form_id                  :integer(4)
#  created_at               :datetime
#  updated_at               :datetime
#

class FilingInfo < ActiveRecord::Base
  # Form:FilingInfo => 1:1
  belongs_to :form
  
  #AoA for filing under section
  RETURNFILE_SECTIONS = [
    # Displayed   , stored in db
    [ "11-u/s 139(1)" , 11 ],
    [ "12-u/s 139(4)" , 12 ],
    [ "13-u/s 142(1)" , 13 ],
    [ "14-u/s 148" , 14 ],
    [ "15-u/s 153A" , 15 ]
  ]  
  ## AoA for filing type
  FILING_TYPES = [
    [ "O-Original" , "O"],
    [ "R-Rivised", "R"]
  ]
  ## AoA for Residential Status
  RESIDENTIAL_STATUS = [
    [ "RES - Resident" , "RES"],
    [ "NRI - Non-Resident", "NRI"],
    [ "NOR - Resident but not normally Resident", "NOR"]
  ]
  # total fields to varify 6
if ($IsValidationOn)
  ### Field 1: validation for :desigOfficerWardorCircle
  validates_presence_of :desigOfficerWardorCircle ,
                        :message => "^Please Enter the Assessing Officer Ward or Circle where the return is to be filed"
  validates_length_of :desigOfficerWardorCircle, :maximum => 40
  
  ### Field 2: validtaion for :returnFileSec1 see AoA RETURNFILE_SECTIONS
  validates_presence_of :returnFileSec1
  validates_inclusion_of :returnFileSec1, :in =>  RETURNFILE_SECTIONS.map {|disp, value| value},
                         :message => "^Plesae Select Any Tax Filing Section form list for Filing Section, \n \t\t Normally It Should be 11-u/s 391(A)"
  
  ### Field 3: validtaion for :returnType1 see AoA FILING_TYPES above
  validates_presence_of :returnType1
  validates_inclusion_of :returnType1 , :in =>  FILING_TYPES.map {|disp, value| value},
                         :message => "^Plesae Select Any Tax Filing TYPE Original or Revised form drop-down list"
 
  ### Field 4: validtaion for :origRetFileDate need to change for next year
  validates_presence_of :origRetFileDate ,
                        :if => Proc.new { |finfo| finfo.returnType1 == "R" }
  #would not work because date does not have size property                      
  #validates_length_of :origRetFileDate, :maximum => 10 ,
  #                    :if => Proc.new { |finfo| finfo.returnType1 == "R" }
  # from plugin for 30 feb
  validates_date  :origRetFileDate
  # custom
  validate :valid_originalfile_date_for_09_10
  #callback to nillify date for original return type
  before_save :delete_date_for_original_return
  
  ### Field 5: validation for :receiptNo
  validates_presence_of :receiptNo , :message => "^If you want to file Revised Return,Pease Provide Receipt No of Original Return, otherwise select Return Type Original Return",
                        :if => Proc.new { |finfo| finfo.returnType1 == "R" }
  validates_length_of :receiptNo, :maximum => 15 ,
                      :if => Proc.new { |finfo| finfo.returnType1 == "R" }
  
  ### Field 6: validation for :residentialStatus1 see AoA RESIDENTIAL_STATUS above
  validates_presence_of :residentialStatus1 , :message => "^Please select Residential Status normally it would be RES for you"
  validates_inclusion_of :residentialStatus1 , :in =>  RESIDENTIAL_STATUS.map {|disp, value| value},
                         :message => "^Plesae Select your Residential Status form drop-down list"                       

end 
## BL Brain Lapses here








  ## sssshhh! secret
  private 
  # for validation
  def valid_originalfile_date_for_09_10
    if returnType1 == "R"
      date_for_original_return = Date.new(2009,04,01)
      if (self.origRetFileDate != nil)
        if date_for_original_return > origRetFileDate
          errors.add(:origRetFileDate, "^If you want to file Revised Return,Please Select a date after 31/3/2009 otherwise select Return Type Original Return" )
        end
      end
    end
  end  
  # for callback
  def delete_date_for_original_return
    # second condition is for case if we are able to ajaxify and disable date and receipt no for Original return
    if self.returnType1 == "O" && self.origRetFileDate != nil
      self.origRetFileDate=nil
    end
  end
  
end
