require 'rubygems'
require 'rjb'
require 'common_flags'

# Global Constant to control the number of rows in 
# T_DSAL table (Item # 21) in pdf
$T_DSAL_PDF_ROW_COUNT = 2

# Global Constant to control the number of rows in 
# T_DSOTH (Item # 22) in pdf 
$T_DSOTH_PDF_ROW_COUNT = 3 

# Global Constant to control the number of rows in 
# T_DSOTH (Item # 22) in pdf 
$TAX_P_PDF_ROW_COUNT = 5 

STATE_HASH = {1 =>"ANDAMAN & NICOBAR ILNDS",#modified the actual State name string to accomodate in PDF space
2 =>"ANDHRA PRADESH",
3 =>"ARUNACHAL PRADESH",
4 =>"ASSAM",
5 =>"BIHAR",
6 =>"CHANDIGARH",
7 =>"DADRA AND NAGAR HAVELI",
8 =>"DAMAN AND DIU",
9 =>"DELHI",
10 =>"GOA",
11 =>"GUJARAT",
12 =>"HARYANA",
13 =>"HIMACHAL PRADESH",
14 =>"JAMMU AND KASHMIR",
15 =>"KARNATAKA",
16 =>"KERALA",
17 =>"LAKHSWADEEP",
18 =>"MADHYA PRADESH",
19 =>"MAHARASHTRA",
20 =>"MANIPUR",
21 =>"MEGHALAYA",
22 =>"MIZORAM",
23 =>"NAGALAND",
24 =>"ORISSA",
25 =>"PONDICHERRY",
26 =>"PUNJAB",
27 =>"RAJASTHAN",
28 =>"SIKKIM",
29 =>"TAMILNADU",
30 =>"TRIPURA",
31 =>"UTTAR PRADESH",
32 =>"WEST BENGAL",
33 =>"CHHATISHGARH",
34 =>"UTTARANCHAL",
35 =>"JHARKHAND",
99 =>"FOREIGN"}


class PdfWriterController < ApplicationController
  # It is the responsibility of caller to make sure that
  # session[:formid] has a valid value of the corresponding
  # form for which pdf has to be written. 
  # TODO - should it be a mandatatory requirement. why not make 
  # it like you pass on the parameter. 
  #
  #
  # But actually the counter argument is that as soon as all the data are filled.
  # this function will be automatically called. NOTE: before calling this we will 
  # have to make sure that all the data in the form is filled in. It may conflict
  # with the design of creation of sub forms. as we crate sybforms without performing
  # any validation.
  before_filter :get_user

  def index
    puts params[:id]
    @form = get_form_paramid(params[:id])
    if(@form != nil)
      write_pdf(@form)
      @pass = "Successfully Generted PDF."
    end
  end
  
  #pdf downlaod
  def pdfdownload
    #@formid = params[:id]
    #@form = Form.find(@formid)
    @form = get_form_paramid(params[:id])
    if(@form != nil)
      @pdf_file_name = get_pdf_filename(@form)
      puts @pdf_file_name
      send_file("#{RAILS_ROOT}/downloadfiles/#{@pdf_file_name}", :filename => "ITR1_#{@form.personal_info.pan.to_s}.pdf", :type => "application/pdf")
    end
  end  
  
  
  protected 
  
  def getNumeralString(istr)
    x = istr.split(//)
    istr = ""
    x.each{|a|
      if a[0] >= '0'[0]   && a[0] <= '9'[0]
        istr = istr +a
      end
    };
    return istr
  end 
  # Form's file name nomenclature logic goes here. It has to be the same, based on which 
  # file has to be retrieved and given back to the user. may depend on the form name and customer name 
  # and other factors. based on random values. Also make sure that you decide it once 
  # and save it in a field  IMP: Do not calculate the name on the fly. That may leave 
  # unreferenced files if name deciding factors get changed at some stage.
  # Basename is common between the XML files and PDF files.  
  def get_form_basename(form)
    @name = form.formName.to_s # form name 
    @name = @name.gsub(/[^0-9a-zA-Z]/,'') 
    @formid = form.id.to_s # it must be unique in the table 
    @created = getNumeralString((form.created_at).to_s)

    @filename = @name + "_" + @formid + "_" + @created    
  end
  
  # gets the forms file name based on the base name file naming policy
  def get_pdf_filename(form)
    @base = get_form_basename(form)
    @filename = @base + ".pdf"
  end
  
  # a making folder to magage generated pdf may be used in future
#  def make_folder_name
#    @day = Date.today.strftime("%d_%m_%Y").to_s
#    @folder= "#{RAILS_ROOT}" + "\/public" + "\/GeneratedPdf" + "\/" + @day
#    if  File.directory?(@folder) 
#      puts"good"
#    else
#      Dir.mkdir @folder
#    end    
#    return @folder
#  end  
 
# returns the string converted based on the amount passwed in as argument  
# TODO - CRITICAL - for (16,2) i.e. 16 digits in total, 2 after decimal work fine.
# beyond that there is a problem. need to solve/check. seems a problem with ruby
# floating point precision
# ASSUMPTION: input must be a number, represented without commas
def amount_to_pdf_string(amount)
  val = ""
  if(amount && amount.to_s.length >0 )
    val = "%.2f" % amount 
    len = val.length
    #puts val  remove first hash to debug
    if(len >5)
      len = len - 3
      x = val.split(//)
      val = ""
      x.each{|a|
        val = val + a  
        if(len >3)
          if((len % 2) == 0)
            val = val + ","
          end
          len = len - 1
        end
      };    
    end
  end
  return val
end 

# returns the string based on the number passed in as argument 
# all the amound to be converted to string using amount_to_pdf_string
def number_to_pdf_string(number)
  val = ""
  if(number && number.to_s.length > 0)
    val = number.to_s
  end
  return val
end

#returns a string in a standard format 
def date_to_pdf_string(date)
  #TODO - check if the format is Indian (DD/MM/YYYY) or not
  if(date)
    date.to_s # last line return value 
  else
  end
end 
 
 # write personal information
  def write_personal_info(pdf, pinfo)
      pdftext "First name" , pinfo.firstName
      pdftext "Middle name" , pinfo.middleName
      pdftext "Last name" , pinfo.surNameOrOrgName
      pdftext "PAN" , pinfo.pan      
      
      pdftext "Name Of PremisesBuildingVillage" , pinfo.residenceName
      pdftext "FlatDoorBlock No" , pinfo.residenceNo
      
      pdftext "AreaLocality" , pinfo.localityOrArea
      pdftext "RoadStreetPost Office" , pinfo.roadOrStreet
      pdftext "DoB" , pinfo.dob
      pdftext "TownCityDistrict" , pinfo.cityOrTownOrDistrict
      pdftext "Pin code" , pinfo.pinCode
      pdftext "State" , STATE_HASH[pinfo.stateCode1]
      pdftext "Email Address" , pinfo.emailAddress
      pdftext "Phone" , pinfo.phoneNo
      pdftext "STD" , pinfo.stdCode
      
    # TODO -STUDY-pinfo.status has not been marked. According to ITR1.xls  
    # status can only Individual and not HUF (needed in ITR2 and other forms)
    # Here, in ITR1 form, as per document status field will exist but there is
    # no place in PDF file to mark it. "Status" info is needed only in Acknowledgement form
    # which ic common among all the ITR forms. 
=begin
      #no field to write in PDF for status
      if pinfo.status == "I"
        pdftext "" , "Yes"
      else
        pdftext "" , "Yes"
      end      
=end      
      #MALE/FEMALE
      if pinfo.gender1 == "M" 
        pdftext "Male" , "Yes"
      else
        pdftext "Female" , "Yes"
      end
      
      #GOVT/PSU/OTHERS
      if pinfo.employerCategory1 == "GOV"
        pdftext "Govt", "Yes" #Govt/PSU/Others
      elsif pinfo.employerCategory1 == "PSU"
        pdftext "PSU", "Yes"
      else
        pdftext "Others", "Yes"
      end      
  end
  
  #write the filing information into the pdf 
  def write_filing_info(pdf, filing_info)
    pdftext "Designation of Assessing Officer WardCircle" ,filing_info.desigOfficerWardorCircle
    pdftext "Section" ,number_to_pdf_string(filing_info.returnFileSec1)    
    
    if filing_info.returnType1 == "O"
     pdftext "Original", "Yes"
    else
     pdftext "Revised", "Yes"
     pdftext "Revised Date" ,filing_info.origRetFileDate
     pdftext "Revised Receipt No" ,filing_info.receiptNo     
    end    
    
    if filing_info.residentialStatus1 == "RES"
      pdftext "RES", "Yes"
    elsif filing_info.residentialStatus1 == "NRI"
      pdftext "NRI", "Yes"
    else filing_info.residentialStatus1 == "RES"
      pdftext "NOR", "Yes"
    end    
  end
  
  
  #write income and deduction info 
  def write_income_and_deduction(pdf,income_and_deduction)
    pdftext "Head Salaries" , amount_to_pdf_string(income_and_deduction.incomeFromSal)
    pdftext "Family pension" , amount_to_pdf_string(income_and_deduction.famPension)
    pdftext "Interest" , amount_to_pdf_string(income_and_deduction.indInterest)
    
    # TODO - assuming that sum of Family Pension and Interest has been done already and
    # proper value saved in incomeFromOS , grossTotIncome , totalChapVIADeductionsfield
    # totalIncome and aggregateIncome. do the calculations somewhere if not taking from user
    pdftext "Total 2a+2b", amount_to_pdf_string(income_and_deduction.incomeFromOS)
    pdftext "Gross Total Income", amount_to_pdf_string(income_and_deduction.grossTotIncome)
    
    pdftext "80C" , amount_to_pdf_string(income_and_deduction.section80C)
    pdftext "80CCC" , amount_to_pdf_string(income_and_deduction.section80CCC)
    pdftext "80CCD" , amount_to_pdf_string(income_and_deduction.section80CCD)
    pdftext "80D" , amount_to_pdf_string(income_and_deduction.section80D)
    pdftext "80DD" , amount_to_pdf_string(income_and_deduction.section80DD)
    pdftext "80DDB" , amount_to_pdf_string(income_and_deduction.section80DDB)
    pdftext "80E" , amount_to_pdf_string(income_and_deduction.section80E)
    pdftext "80G" , amount_to_pdf_string(income_and_deduction.section80G)
    pdftext "80GG" , amount_to_pdf_string(income_and_deduction.section80GG)
    pdftext "80GGA" , amount_to_pdf_string(income_and_deduction.section80GGA)
    pdftext "80GGC" , amount_to_pdf_string(income_and_deduction.section80GGC)
    pdftext "80U" , amount_to_pdf_string(income_and_deduction.section80U)

    pdftext "Total Deductions under chapter VI A Section", amount_to_pdf_string(income_and_deduction.totalChapVIADeductions)
    pdftext "Total Income", amount_to_pdf_string(income_and_deduction.totalIncome)
    
    pdftext "Net Agricultural Income" , amount_to_pdf_string(income_and_deduction.netAgriculturalIncome)    
    pdftext "Aggregate Income 5+6", amount_to_pdf_string(income_and_deduction.aggregateIncome)
  end
  
   
   # Asssuming that the virtual fields are calculated at a right place and stored n the 
   # database with appropriate value. 
   # TODO - check where/whether to calculate
  def write_tax_computation(pdf, tax_computation)
    pdftext "Tax Payable on Aggregate Income" , amount_to_pdf_string(tax_computation.taxOnAggregateInc)
    pdftext "Rebate iro Agriculture Income" , amount_to_pdf_string(tax_computation.rebateOnAgriInc)    
    pdftext "Tax Payable on Total Income 8a-8b" , amount_to_pdf_string(tax_computation.totalTaxPayable)
    pdftext "Surcharge on Tax Payable" , amount_to_pdf_string(tax_computation.surchargeOnTaxPayable)
    pdftext "Education cess" , amount_to_pdf_string(tax_computation.educationCess)
    pdftext "Total Tax, Surcharge and Education Cess" , amount_to_pdf_string(tax_computation.grossTaxLiability)
    pdftext "Relief under Section 89" , amount_to_pdf_string(tax_computation.section89)
    pdftext "Relief under Section 90/91" , amount_to_pdf_string(tax_computation.section90and91)
    pdftext "Balance Tax Payable" , amount_to_pdf_string(tax_computation.netTaxLiability)

    pdftext "Interest Payable U/s 234A" , amount_to_pdf_string(tax_computation.intrstPayUs234A)
    pdftext "Interest Payable U/s 234B" , amount_to_pdf_string(tax_computation.intrstPayUs234B)
    pdftext "Interest Payable U/s 234C" , amount_to_pdf_string(tax_computation.intrstPayUs234C)
    
    pdftext "Total Interest Payable" , amount_to_pdf_string(tax_computation.totalIntrstPay)
    pdftext "Total Tax and Interest Payable" , amount_to_pdf_string(tax_computation.totTaxPlusIntrstPay)
end
    
  
  # Write Anual Information Return into the pdf
  # TODO - do the string processing
  def write_air(pdf, air)
      pdftext "Transcation 001" , amount_to_pdf_string(air.code001)
      pdftext "Transcation 002" , amount_to_pdf_string(air.code002)
      pdftext "Transcation 003" , amount_to_pdf_string(air.code003)
      pdftext "Transcation 004" , amount_to_pdf_string(air.code004)
      pdftext "Transcation 005" , amount_to_pdf_string(air.code005)
      pdftext "Transcation 006" , amount_to_pdf_string(air.code006)
      pdftext "Transcation 007" , amount_to_pdf_string(air.code007)
      pdftext "Transcation 008" , amount_to_pdf_string(air.code008)
      pdftext "Tax-exempt interest income for reporting purposes only" , amount_to_pdf_string(air.taxExmpIntInc)
  end
  
  # write Tax Paid and Refund Information 
  def write_tax_paid_and_refund(pdf, tax_paid_and_refund)
    pdftext "Total Taxes Paid" , amount_to_pdf_string(tax_paid_and_refund.totalTaxesPaid)
    pdftext "Tax Payable" , amount_to_pdf_string(tax_paid_and_refund.balTaxPayable)
    pdftext "Refund" , amount_to_pdf_string(tax_paid_and_refund.refundDue)
    pdftext "Advance Tax" , amount_to_pdf_string(tax_paid_and_refund.advanceTax)
    pdftext "TDS" , amount_to_pdf_string(tax_paid_and_refund.tds)
    pdftext "Self Assessement Tax" , amount_to_pdf_string(tax_paid_and_refund.selfAssessmentTax)

    @redfund_due = tax_paid_and_refund.refundDue

    if @redfund_due && @redfund_due > 0.0
      pdftext "Bank Account Number for Refund" , number_to_pdf_string(tax_paid_and_refund.bankAccountNumber)
      if tax_paid_and_refund.ecsRequired == "N"
        pdftext "Cheque", "Yes"
      else
        pdftext "Deposit", "Yes"        
        if tax_paid_and_refund.bankAccountType == "SAV"
          pdftext "Savings", "Yes"
        else 
          pdftext "Current", "Yes"
        end
        pdftext "MICR Code" , number_to_pdf_string(tax_paid_and_refund.micrCode)
      end
    end
  end
  
  # Basically on the form user will intend to give full data but 
  # when writing into the pdf, we will face difficulty in writing
  # the whole string, if it is too large. In such case, let's cut
  # the address short such that it has Name and address adjustable
  # to the maximum size that can be filled in
  #
  # Bangalore 560071  => Bangalore-71 
  # ABC Software India  => ABC
  # A-002 Purva Paradise => A-002
  # ASSUMPTION :
  # ==> pin must be integer, rest can be string
  # ==> 
  def get_small_addr(empname,addr,city,state,pin)
    # TODO - currently relying on the truncation of the string 
    # by pdf writer itself but later on need to to the manipluation
    # on our own
    @small = ""

    if(!empname.nil?)
     @small = empname + ","
    end      

    if(!addr.nil?)
      @small = @small + addr +  "\n" 
    end
    
    if(!city.nil?)
      @small = @small + city
    end

    if(pin != nil)
      @small = @small + "-" + (pin%100).to_s
    end
    
    if(state!= nil)
      @statename = STATE_HASH[state.to_i]
      if(@statename != nil)
        @small = @small + ", " + @statename
      end
    end
    return @small
  end
  
  # write SINGLE t_dsal entry into the pdf 
  def write_t_dsal(pdf,count,t_dsal)
    @prefix = "Employer" + count.to_s + " "
    
    @optname = get_small_addr(t_dsal.employerOrDeductorOrCollecterName,
                  t_dsal.addrDetail,t_dsal.cityOrTownOrDistrict, t_dsal.stateCode,
                  t_dsal.pinCode)    
    pdftext( (@prefix + "TAN") , t_dsal.tan)
    pdftext( (@prefix + "UTN") , t_dsal.utn)
    pdftext( (@prefix + "Name and address") ,@optname)    
    pdftext( (@prefix + "Income un Head Salaries") , amount_to_pdf_string(t_dsal.incChrgSal))
    pdftext( (@prefix + "Deduction") , amount_to_pdf_string(t_dsal.deductUnderChapVIA))
    pdftext( (@prefix + "Tax Payable incd") , amount_to_pdf_string(t_dsal.taxPayIncluSurchEdnCes))
    pdftext( (@prefix + "Total tax deducted") , amount_to_pdf_string(t_dsal.totalTDSSal))
    pdftext( (@prefix + "Tax payable refundable") , amount_to_pdf_string(t_dsal.taxPayRefund))
  end
  
  #write SINGLE t_dsoth entry into the pdf
  def write_t_dsoth(pdf,count,t_dsoth)
    @prefix = "Deductor" + count.to_s + " "
    @optname = get_small_addr(t_dsoth.employerOrDeductorOrCollecterName,
                  t_dsoth.addrDetail,t_dsoth.cityOrTownOrDistrict, t_dsoth.stateCode,
                  t_dsoth.pinCode)
                  
    pdftext( (@prefix +"TAN") , t_dsoth.tan)
    pdftext( (@prefix +"UTN") , t_dsoth.utn)
    pdftext( (@prefix + "Name and address") ,@optname)    
    pdftext( (@prefix +"Amount paid credited") , amount_to_pdf_string(t_dsoth.amtPaid))
    pdftext( (@prefix +"DoPC") , date_to_pdf_string(t_dsoth.datePayCred))
    pdftext( (@prefix +"Total tax deducted") , amount_to_pdf_string(t_dsoth.totTDSOnAmtPaid))
    pdftext( (@prefix +"Amout claimed") , amount_to_pdf_string(t_dsoth.claimOutOfTotTDSOnAmtPaid))    
  end
  
  #write SINGLE tax_p entry into the pdf
  def write_tax_p(pdf,count,tax_p)    
    @prefix = "ATSAT" + count.to_s + " "
    @optname = tax_p.nameOfBank.to_s #+ tax_p.nameOfBranch.to_s
    pdftext( (@prefix + "Amount") , amount_to_pdf_string(tax_p.amt))
    pdftext( (@prefix + "Name of Bank & Branch") , @optname)
    pdftext( (@prefix + "BSR Code") , number_to_pdf_string(tax_p.bsrCode))
    pdftext( (@prefix + "DoD") , date_to_pdf_string(tax_p.dateDep))
    pdftext( (@prefix + "Serial Number of Challan") , number_to_pdf_string(tax_p.srlNoOfChaln))
    
  end
  
  #writes t_DSAL table into the pdf form
  def write_t_dsals(pdf,tax_paid_and_refund)
    @t_dsals = tax_paid_and_refund.t_dsals    
    @count = 0 # represents the number of rows written
    
    for @t_dsal in @t_dsals 
      
      if @count < $T_DSAL_PDF_ROW_COUNT # TABLE NOT COMPLETELY FILLED
        @count = @count + 1
        write_t_dsal(pdf,@count,@t_dsal)
      end
    end # end of loop      
    
    if @count < @t_dsals.size #not written all the values into the string. 
      #TODO - CRASH - report user that his data exceeds the available options in 
      # in the form         
    end        
  end # end of function 
  
  #writes the T_DSOTH table into the pdf form
  def write_t_dsoths(pdf,tax_paid_and_refund)
    @t_dsoths = tax_paid_and_refund.t_dsoths
    @count = 0
    for @t_dsoth in @t_dsoths
      if @count < $T_DSOTH_PDF_ROW_COUNT
        @count = @count + 1
        write_t_dsoth(pdf,@count,@t_dsoth)
      end      
    end
    
    if @count < @t_dsoths.size
      #TODO - CRASH -
      #use flash[:notice] = "You have data more than it can be accomodated in the form"
    end
  end
  
  #write the TAX_P table into the pdf form
  def write_tax_ps(pdf,tax_paid_and_refund)
    @tax_ps = tax_paid_and_refund.tax_ps
    @count = 0
    
    for @tax_p in @tax_ps
      if @count < $TAX_P_PDF_ROW_COUNT
        @count = @count + 1
        write_tax_p(pdf,@count,@tax_p)
      end      
    end
    
    if @count < @tax_ps.size
      #TODO - CRASH - flash[:notice] = "YOU have more data than it can be accomodated
      # in the form"
    end
  end
  
  # write ver information to PDF
def write_ver(pdf,ver)   
   pdftext "Name", ver.assesseeVerName
   pdftext "FatherName" , ver.fatherName   
   pdftext "Place" , ver.place
   pdftext "Date" , ver.date
   pdftext "Identification No. of TRP" , ver.identificationNoOfTRP
   pdftext "Name of TRP" , ver.nameOfTRP
   pdftext "TRP Amount" , amount_to_pdf_string(ver.reImbFrmGov)
end  

  #TODO - Acknowledge Form part of the final form
  # Get the values for the following fields. They need to be get from somewhere.
  def write_acknowledge(pdf,name,status,type,grosstotal)
    pdftext "Received from", name
    pdftext "Status I or H", status # not clear
    pdftext "Original or Revised", type
    pdftext "Gross total income in ACK", amount_to_pdf_string(grosstotal)
  end

def writePDFCore(pdf,form)
  @pdf = pdf
  @form = form
  
  write_personal_info(@pdf,@form.personal_info) # write personal information
  write_filing_info(@pdf,@form.filing_info)
  write_income_and_deduction(@pdf,@form.income_and_deduction)
  write_tax_computation(@pdf,@form.tax_computation)
  write_tax_paid_and_refund(@pdf,@form.tax_paid_and_refund)
  write_t_dsals(@pdf,@form.tax_paid_and_refund)
  write_t_dsoths(@pdf,@form.tax_paid_and_refund)
  write_tax_ps(@pdf,@form.tax_paid_and_refund)
  write_air(@pdf,@form.air)
  write_ver(@pdf,@form.ver)
  #TODO - need to evaluate the fields before writing acknowledgement
  #write_acknowledge(@pdf,name,status,type,grosstotal)
  
  # TODO - handle in a better way. 
  # save it with the name and in profile
  
end

def write_pdf(form)
  @form = form
  @pdf_itr1_template = "#{RAILS_ROOT}/ITR_data/Forms/ITR1_template.pdf"
  @pdf_file_name = get_pdf_filename(@form)
  @pdf_file_with_folder_name = "#{RAILS_ROOT}/downloadfiles/"+ @pdf_file_name
  
  Rjb::load(File.join("#{RAILS_ROOT}/lib/itrpdf/iText-2.1.5.jar"))
  filestream   = Rjb::import('java.io.FileOutputStream')
  acrofields   = Rjb::import('com.lowagie.text.pdf.AcroFields')
  pdfreader    = Rjb::import('com.lowagie.text.pdf.PdfReader')
  pdfstamper   = Rjb::import('com.lowagie.text.pdf.PdfStamper')

  reader = pdfreader.new( @pdf_itr1_template )
  @stamp = pdfstamper.new( reader, filestream.new(@pdf_file_with_folder_name) )
  @pdf = @stamp.getAcroFields() 
  if(@pdf)
    writePDFCore(@pdf,@form)
    pdfclose
  else
    if($IsDebug)
      puts '@Error: Can not find template to generate pdf'
    end
  end
end

def pdftext( key, value )
    @pdf.setField( key, value.to_s )
end

def pdfclose
    @stamp.setFormFlattening(true)
    @stamp.close
end  
 


#END OF THE CLASS
end
