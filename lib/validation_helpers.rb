
$IsValidationOn=true

# validate the PAN number as per the India rules
# rules -> 10 letters in length , First 5 digit have to be alphabet ,
# next 4 digit and last one a alphabet again
# TAN and PAN share the same rules for validation .
def vdate_pan(attr)
  # by default must be present
  validates_presence_of attr

  # check for the length, TAN/PAN both have to be 10 character long
  validates_length_of attr , :is => 10 , :message => "^PAN is of exactly 10 characters "

  # pattenr matching such that FIRST 5 - Char , Next 4 - Digit
  # and last one is CHAR again in 10 chracters of the PAN number
  validates_format_of attr ,
  :with => /[A-Z]{5}\d{4}[A-Z]{1}/ ,
  :message => "^invalid PAN format, First five alphabets, next four numerals and last again alpahbet e.g.AAAAA4444A"
end

# validate the TAN number as per the India rules
# rules -> 10 letters in length , First 4 digit have to be alphabet ,
# next 5 digit and last one a alphabet again
# TAN and PAN share the same rules for validation .
def vdate_tan(attr)
  # by default must be present
  validates_presence_of attr

  # check for the length, TAN/PAN both have to be 10 character long
  validates_length_of attr , :is => 10 , :message => "^TAN is of exactly 10 characters "

  # pattenr matching such that FIRST 4 - Char , Next 5 - Digit
  # and last one is CHAR again in 10 chracters of the PAN number
  validates_format_of attr ,
  :with => /[A-Z]{4}\d{5}[A-Z]{1}/ ,
  :message => "^invalid TAN format, First four alphabets, next five numerals and last again alpahbet e.g.AAAA55555A"
end

# validate the UTN number as per the India rules
# not required for 09-10
#def vdate_utn(attr)
#  # by default must be present
#  validates_presence_of attr
#
#  # check for the length, TAN/PAN both have to be 10 character long
#  validates_length_of attr , :is => 10 , :message => "^TAN is of exactly 10 characters "
#
#  # pattenr matching such that FIRST 4 - Char , Next 5 - Digit
#  # and last one is CHAR again in 10 chracters of the PAN number
#  validates_format_of attr ,
#  :with => /[A-Z]{5}\d{4}[A-Z]{1}/ ,
#  :message => "^invalid TAN format"
#end

# validate the "attr" against the maximum length
# if present is set to be TRUE then value must be present
def vdate_name_maxlen(attr, len, presence, attr_err_name)
  # check against the NIL value
  if(presence == 1)#can not be NIL
      validates_presence_of attr , :message => "^Field #{attr_err_name} is not filled"
  end

  # length must be less than 'len'
  validates_length_of attr , :maximum => len , :message => "^Field #{attr_err_name} can have maximum #{len} characters"
end


# validates the Indian PIN Code# as per ITR1 norms NRI can enter 999999 as the PIN code
# TODO - make sure that first character is not a sign. that validation is
# not being done by validate_uniqueness
def vdate_pin(attr)
validates_presence_of attr , :message => "^Please Fill #{attr}"
validates_format_of attr ,  :with => /^\d{6}$/ ,
                      :message => "^invalid #{attr}, #{attr} is 6 digit number"
end

# validates indian phone number as per ITR1 rules
# TODO - make sure that +/- is not in front of the number
def vdate_std_code_phone(std,phone)
  validates_numericality_of std , :only_integer => true ,
                                  :message => "^STD Code only numerals no + sign"
  validates_numericality_of phone , :only_integer => true , :message => "^Field Phone can have only numerals"

  validates_length_of std , :maximum => 5 , :message => "^Field STD Code contains more than 5 digits"
  validates_length_of phone , :maximum => 10 , :message => "^Field Phone contains more than 10 digits"
=begin
TODO - correct the following code to insert the logic of phone number validation
  if(phone.length == 10)# mobile phone number
     errors.add(std,'must be 91 if a cell phone number') if std != 91
  else
#    TODO - make sure first character in not ZERO. => same logic as in case to check the sign
  end
=end
end

#validate email address
def vdate_email_address(attr)
  validates_length_of attr , :maximum => 125
  validates_format_of attr ,
  :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i ,
  :message => "^Invalid Email Address format"
end


# validate amount range as per the amount possible in Income Tax guide. Since we are not
# comparing for the equality it must be automatically doing the difference calculation
# and then taking the decision. Ruby and databases ensure that decimal numbers are stored
# to exact precision
# ASSUMPTION : has been called on decimal only.
def vdate_is_valid_amount_range?(attr)
  if(attr < 0 || attr > 99999999999999)
    return false
  else
    return true
  end
  end