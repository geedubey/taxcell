require 'rubygems'
#require 'builder'
require 'nokogiri'
#require 'libxml'

## formating of stateCode at 3 places be "%02d" % field name
## date formating back to US style using .strftime(%Y-%m-%d)
## all amounts in database is decimal coverting(.to_i) that into integer as in xml its xs:longint 

class XmlWriterController < ApplicationController
  
  before_filter :get_user
  
  
  # index method to invoke generation and validation of xml
  def index
    @form = get_form_paramid(params[:id])
    if(@form != nil )
      xml_main(@form)
      val_err = validate(@form) 
      if (val_err == nil)
        @pass = "Successfully Generted XML to be uploaded at https://incometaxindiaefiling.gov.in"
      else
        logger.error "validate.to_s"
      end
    end
  end
 

  # xml downlaod
  def xmldownload
    @form = get_form_paramid(params[:id])
    if(@form != nil)
      @xml_file_name = get_xml_filename(@form)
      puts @xml_file_name
      send_file("#{RAILS_ROOT}/downloadfiles/#{@xml_file_name}", :filename => "ITR1_#{@form.personal_info.pan.to_s}.xml", :type => "application/xml")
    end
  end  

 
 protected 
  ## form creation info
  def xml_formcreation_info(xml)
        xml.tag!("ITRForm:CreationInfo") {
          xml.tag!("ITRForm:SWVersionNo", "R1") 
          xml.tag!("ITRForm:SWCreatedBy", "DIT")
          xml.tag!("ITRForm:XMLCreatedBy", "DIT" )
          xml.tag!("ITRForm:XMLCreationDate", "2009-04-01")
          xml.tag!("ITRForm:IntermediaryCity", "Delhi")
        }
  end
  
  ## ITR1 info
  def xml_itr1_info(xml)
        xml.tag!("ITRForm:Form_ITR1") {
          xml.tag!("ITRForm:FormName","ITR-1")
          xml.tag!("ITRForm:Description", "For Indls having Income from Salary, Pension, family pension and Interest")
          xml.tag!("ITRForm:AssessmentYear", "2009")
          xml.tag!("ITRForm:SchemaVer", "Ver1.0")
          xml.tag!("ITRForm:FormVer", "Ver1.0")
        }
  end
  
  ## write personal info 
  def xml_personal_info(xml,pinfo)
   
  xml.tag!("ITRForm:PersonalInfo") {
          xml.tag!("ITRForm:AssesseeName") {
            xml.tag!("ITRForm:FirstName", pinfo.firstName)
            xml.tag!("ITRForm:MiddleName", pinfo.middleName)
            xml.tag!("ITRForm:SurNameOrOrgName", pinfo.surNameOrOrgName)
          }
          xml.tag!("ITRForm:PAN", pinfo.pan)
          xml.tag!("ITRForm:Address") {
            xml.tag!("ITRForm:ResidenceNo", pinfo.residenceNo)
            xml.tag!("ITRForm:ResidenceName", pinfo.residenceName)
            xml.tag!("ITRForm:RoadOrStreet", pinfo.roadOrStreet)
            xml.tag!("ITRForm:LocalityOrArea", pinfo.localityOrArea)
            xml.tag!("ITRForm:CityOrTownOrDistrict", pinfo.cityOrTownOrDistrict)
            xml.tag!("ITRForm:StateCode", "%02d" % pinfo.stateCode1)
            xml.tag!("ITRForm:PinCode", pinfo.pinCode)
            xml.tag!("ITRForm:Phone") {
              xml.tag!("ITRForm:STDcode", pinfo.stdCode)
              xml.tag!("ITRForm:PhoneNo", pinfo.phoneNo)
            }
            xml.tag!("ITRForm:EmailAddress", pinfo.emailAddress)
          } 
          xml.tag!("ITRForm:DOB", pinfo.dob.strftime("%Y-%m-%d"))
          xml.tag!("ITRForm:EmployerCategory", pinfo.employerCategory1)
          xml.tag!("ITRForm:Gender", pinfo.gender1)
          xml.tag!("ITRForm:Status", pinfo.status)
        }
  end
  
  ## Filing Status
  def xml_filing_info(xml, filing_info)
    xml.tag!("ITRForm:FilingStatus") {
          xml.tag!("ITRForm:DesigOfficerWardorCircle", filing_info.desigOfficerWardorCircle)
          xml.tag!("ITRForm:ReturnFileSec", filing_info.returnFileSec1)
          xml.tag!("ITRForm:ReturnType", filing_info.returnType1)
          xml.tag!("ITRForm:ReceiptNo", filing_info.receiptNo)
          if (filing_info.origRetFileDate)
          xml.tag!("ITRForm:OrigRetFiledDate", filing_info.origRetFileDate.strftime("%Y-%m-%d"))
          end
          xml.tag!("ITRForm:ResidentialStatus", filing_info.residentialStatus1)
          # extra repre details
          xml.tag!("ITRForm:AsseseeRepFlg", "N")
          xml.tag!("ITRForm:AssesseeRep") {
            xml.tag!("ITRForm:RepName", "String")
            xml.tag!("ITRForm:RepAddress", "String")
            xml.tag!("ITRForm:RepPAN", "AAAAA0000A")
          } 
     }
  end
 
  ## INcome and Dedution
  def xml_income_and_deduction(xml,income_and_deduction)
    xml.tag!("ITRForm:IncomeDeductions") {
          xml.tag!("ITRForm:IncomeFromSal", income_and_deduction.incomeFromSal.to_i)
          xml.tag!("ITRForm:IncomeOthSrc") {
            xml.tag!("ITRForm:FamPension", income_and_deduction.famPension.to_i)
            xml.tag!("ITRForm:IndInterest", income_and_deduction.indInterest.to_i)
            xml.tag!("ITRForm:IncomeFromOS", income_and_deduction.incomeFromOS.to_i)
          }
          xml.tag!("ITRForm:GrossTotIncome", income_and_deduction.grossTotIncome.to_i)
          xml.tag!("ITRForm:DeductUndChapVIA") {  
            xml.tag!("ITRForm:Section80C", income_and_deduction.section80C.to_i)
            xml.tag!("ITRForm:Section80CCC", income_and_deduction.section80CCC.to_i)
            xml.tag!("ITRForm:Section80CCD", income_and_deduction.section80CCD.to_i)
            xml.tag!("ITRForm:Section80D", income_and_deduction.section80D.to_i)
            xml.tag!("ITRForm:Section80DD", income_and_deduction.section80DD.to_i)
            xml.tag!("ITRForm:Section80DDB", income_and_deduction.section80DDB.to_i)
            xml.tag!("ITRForm:Section80E", income_and_deduction.section80E.to_i)
            xml.tag!("ITRForm:Section80G", income_and_deduction.section80G.to_i)
            xml.tag!("ITRForm:Section80GG", income_and_deduction.section80GG.to_i)
            xml.tag!("ITRForm:Section80GGA", income_and_deduction.section80GGA.to_i)
            xml.tag!("ITRForm:Section80GGC", income_and_deduction.section80GGC.to_i)
            xml.tag!("ITRForm:Section80U", income_and_deduction.section80U.to_i)
            # extra set to 0
            xml.tag!("ITRForm:Section80RRB", "0")
            xml.tag!("ITRForm:Section80QQB", "0")
            xml.tag!("ITRForm:Section80IA", "0")
            xml.tag!("ITRForm:Section80IAB", "0")
            xml.tag!("ITRForm:Section80IB", "0")
            xml.tag!("ITRForm:Section80IC", "0")
            xml.tag!("ITRForm:Section80JJA", "0")
            xml.tag!("ITRForm:TotalChapVIADeductions", income_and_deduction.totalChapVIADeductions.to_i)   
          }
          xml.tag!("ITRForm:TotalIncome", "250000")
          xml.tag!("ITRForm:NetAgriculturalIncome", income_and_deduction.netAgriculturalIncome.to_i)
          xml.tag!("ITRForm:AggregateIncome", income_and_deduction.aggregateIncome.to_i)
        }
  end
  
  ## TAX Computation
  def xml_tax_computation(xml,tax_computation)
    xml.tag!("ITRForm:TaxComputation") {
          xml.tag!("ITRForm:TaxOnAggregateInc", tax_computation.taxOnAggregateInc.to_i)
          xml.tag!("ITRForm:RebateOnAgriInc", tax_computation.rebateOnAgriInc.to_i)
          xml.tag!("ITRForm:TotalTaxPayable", tax_computation.totalTaxPayable.to_i)
          xml.tag!("ITRForm:SurchargeOnTaxPayable", tax_computation.surchargeOnTaxPayable.to_i)
          xml.tag!("ITRForm:EducationCess", tax_computation.educationCess.to_i)
          xml.tag!("ITRForm:GrossTaxLiability", tax_computation.grossTaxLiability.to_i)
          xml.tag!("ITRForm:Section89", tax_computation.section89.to_i)
          xml.tag!("ITRForm:Section90and91", tax_computation.section90and91.to_i)
          xml.tag!("ITRForm:NetTaxLiability", tax_computation.netTaxLiability.to_i)
          xml.tag!("ITRForm:IntrstPay") {
            xml.tag!("ITRForm:IntrstPayUs234A", tax_computation.intrstPayUs234A.to_i)
            xml.tag!("ITRForm:IntrstPayUs234B", tax_computation.intrstPayUs234B.to_i)
            xml.tag!("ITRForm:IntrstPayUs234C", tax_computation.intrstPayUs234C.to_i)
            xml.tag!("ITRForm:TotalIntrstPay", tax_computation.totalIntrstPay.to_i)
          } 
          xml.tag!("ITRForm:TotTaxPlusIntrstPay", tax_computation.totTaxPlusIntrstPay.to_i)
        }
  end  
  
  ## tax paid <tax and refund part1 :one table>
  def xml_tax_paid(xml,tax_paid_and_refund)
    xml.tag!("ITRForm:TaxPaid") {
          xml.tag!("ITRForm:TaxesPaid") {
            xml.tag!("ITRForm:AdvanceTax", tax_paid_and_refund.advanceTax.to_i)
            xml.tag!("ITRForm:TDS", tax_paid_and_refund.tds.to_i)
            #extra TCS
            xml.tag!("ITRForm:TCS", "00")
            xml.tag!("ITRForm:SelfAssessmentTax", tax_paid_and_refund.selfAssessmentTax.to_i)
            xml.tag!("ITRForm:TotalTaxesPaid", tax_paid_and_refund.totalTaxesPaid.to_i)
          }
          xml.tag!("ITRForm:BalTaxPayable", tax_paid_and_refund.balTaxPayable.to_i)
        }
  end
  
  ## tax refund <tax and refund part1 :one table>
  def xml_tax_refund(xml,tax_paid_and_refund)
    xml.tag!("ITRForm:Refund") {
          xml.tag!("ITRForm:RefundDue", tax_paid_and_refund.refundDue.to_i)
          xml.tag!("ITRForm:BankAccountNumber", tax_paid_and_refund.bankAccountNumber)
          xml.tag!("ITRForm:EcsRequired", tax_paid_and_refund.ecsRequired)
          if (tax_paid_and_refund.ecsRequired == "Y")
          xml.tag!("ITRForm:DepositToBankAccount") {
            xml.tag!("ITRForm:MICRCode", tax_paid_and_refund.micrCode) #9 digit
            xml.tag!("ITRForm:BankAccountType", tax_paid_and_refund.bankAccountType)
          } 
          end
        }  
  end
  
  ## AIR plus tax exempt
  def xml_air_and_tax_exempt(xml,air)
    xml.tag!("ITRForm:AIRInfo") {
          xml.tag!("ITRForm:Code001", air.code001.to_i)
          xml.tag!("ITRForm:Code002", air.code002.to_i)
          xml.tag!("ITRForm:Code003", air.code003.to_i)
          xml.tag!("ITRForm:Code004", air.code004.to_i)
          xml.tag!("ITRForm:Code005", air.code005.to_i)
          xml.tag!("ITRForm:Code006", air.code006.to_i)
          xml.tag!("ITRForm:Code007", air.code007.to_i)
          xml.tag!("ITRForm:Code008", air.code008.to_i)    
        }
     xml.tag!("ITR1FORM:TaxExmpIntInc", air.taxExmpIntInc.to_i)   
  end
  
  ## Tax on salaries
  def xml_t_dsals(xml,tax_paid_and_refund)
    xml.tag!("ITRForm:TDSonSalaries") {
     
     # tax_paid_and_refund has many tax dedution on salaries so iterate over one by one
      tax_paid_and_refund.t_dsals.each do |t_dsal|
         xml.tag!("ITRForm:TDSonSalary") {
              xml.tag!("ITRForm:EmployerOrDeductorOrCollectDetl") {
                xml.tag!("ITRForm:TAN", t_dsal.tan)
                xml.tag!("ITRForm:UTN", t_dsal.utn)
                xml.tag!("ITRForm:EmployerOrDeductorOrCollecterName", t_dsal.employerOrDeductorOrCollecterName)
                xml.tag!("ITRForm:AddressDetail") {
                  xml.tag!("ITRForm:AddrDetail", t_dsal.addrDetail)
                  xml.tag!("ITRForm:CityOrTownOrDistrict", t_dsal.cityOrTownOrDistrict)
                  xml.tag!("ITRForm:StateCode", "%02d" % t_dsal.stateCode)
                  xml.tag!("ITRForm:PinCode", t_dsal.pinCode)
                }
              }  
              xml.tag!("ITRForm:IncChrgSal", t_dsal.incChrgSal.to_i)
              xml.tag!("ITRForm:DeductUnderChapVIA", t_dsal.deductUnderChapVIA.to_i)
              xml.tag!("ITRForm:TaxPayIncluSurchEdnCes", t_dsal.taxPayIncluSurchEdnCes.to_i)
              xml.tag!("ITRForm:TotalTDSSal", t_dsal.totalTDSSal.to_i)
              xml.tag!("ITRForm:TaxPayRefund", t_dsal.taxPayRefund.to_i)
            }
      end
   
    }
  end  
  
  ## Tax on other than salaries
  def xml_t_dsoths(xml,tax_paid_and_refund)
    xml.tag!("ITRForm:TDSonOthThanSals") {   
       #tax_paid_and_refund has many tax other that salaries getting array an looping 
       tax_paid_and_refund.t_dsoths .each do |t_dsoth|
         xml.tag!("ITRForm:TDSonOthThanSal") {
              xml.tag!("ITRForm:EmployerOrDeductorOrCollectDetl") {
                xml.tag!("ITRForm:TAN", t_dsoth.tan)
                xml.tag!("ITRForm:UTN", t_dsoth.utn)
                xml.tag!("ITRForm:EmployerOrDeductorOrCollecterName", t_dsoth.employerOrDeductorOrCollecterName)
                xml.tag!("ITRForm:AddressDetail") {
                  xml.tag!("ITRForm:AddrDetail", t_dsoth.addrDetail)
                  xml.tag!("ITRForm:CityOrTownOrDistrict", t_dsoth.cityOrTownOrDistrict)
                  xml.tag!("ITRForm:StateCode", "%02d" % t_dsoth.stateCode)
                  xml.tag!("ITRForm:PinCode", t_dsoth.pinCode)
                }
              }  
              xml.tag!("ITRForm:AmtPaid", t_dsoth.amtPaid.to_i)
              xml.tag!("ITRForm:DatePayCred", t_dsoth.datePayCred.strftime("%Y-%m-%d"))
              xml.tag!("ITRForm:TotTDSOnAmtPaid", t_dsoth.totTDSOnAmtPaid.to_i)
              xml.tag!("ITRForm:ClaimOutOfTotTDSOnAmtPaid", t_dsoth.claimOutOfTotTDSOnAmtPaid.to_i)
            }
       end  
    }    
  end
  
  ## Advanced tax paid
  def xml_tax_ps(xml,tax_paid_and_refund)
    xml.tag!("ITRForm:TaxPayments") {
    #tax_paid_and_refund has many advanced tax paid; getting array an looping 
    tax_paid_and_refund.tax_ps.each do |tax_p|
       xml.tag!("ITRForm:TaxPayment") {
              xml.tag!("ITRForm:NameOfBankAndBranch") {
                xml.tag!("ITRForm:NameOfBank", tax_p.nameOfBank)
                xml.tag!("ITRForm:NameOfBranch", tax_p.nameOfBranch)
              }
              xml.tag!("ITRForm:BSRCode", tax_p.bsrCode)
              xml.tag!("ITRForm:DateDep", tax_p.dateDep.strftime("%Y-%m-%d"))
              xml.tag!("ITRForm:SrlNoOfChaln", tax_p.srlNoOfChaln)
              xml.tag!("ITRForm:Amt", tax_p.amt.to_i)
            }
    end
    }
  end
  
  ## verification
  def xml_ver(xml,ver,pinfo)
    xml.tag!("ITRForm:Verification") {
          xml.tag!("ITRForm:Declaration") {
            xml.tag!("ITRForm:AssesseeVerName", ver.assesseeVerName)
            xml.tag!("ITRForm:FatherName", ver.fatherName)
            xml.tag!("ITRForm:AssesseeVerPAN", pinfo.pan)
          }
          xml.tag!("ITRForm:Place", ver.place)
          xml.tag!("ITRForm:Date", ver.date.strftime("%Y-%m-%d"))
        }       
  end
  
  ## TRP in ver table
  def xml_tax_preparer(xml,ver)
        xml.tag!("ITRForm:TaxReturnPreparer") {
          xml.tag!("ITRForm:IdentificationNoOfTRP", ver.identificationNoOfTRP)
          xml.tag!("ITRForm:NameOfTRP", ver.nameOfTRP)
          xml.tag!("ITRForm:ReImbFrmGov", ver.reImbFrmGov.to_i)
        } 
  end     
  
  # copied from pdf_writer 
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
  def get_form_basename(form)
    @name = form.formName.to_s # form name 
    @name = @name.gsub(/[^0-9a-zA-Z]/,'')
    @formid = form.id.to_s # it must be unique in the table 
    @created = getNumeralString((form.created_at).to_s)

    @filename = @name + "_" + @formid + "_" + @created    
  end
  
  # gets the forms file name based on the base name file naming policy
  def get_xml_filename(form)
    @base = get_form_basename(form)
    @filename = @base + ".xml"
  end


  ## main write 
  def xml_main(form)
    ## FORM
    #@formid = params[:id]
    #@form = Form.find(@formid)
    @form = form
    @xml_file_name = get_xml_filename(@form)
    puts "#{RAILS_ROOT}/downloadfiles/#{@xml_file_name}"
    
    file = File.new("#{RAILS_ROOT}/downloadfiles/#{@xml_file_name}" , "w")
    
    xml = Builder::XmlMarkup.new( :target => file, :indent => 4 ) 
    
    xml.instruct! :xml, :version => "1.0", :encoding => "ISO-8859-1"
    
    xml.tag!("ITRETURN:ITR", "xsi:schemaLocation".to_sym => "http://incometaxindiaefiling.gov.in/main ITRMain09.xsd", "xmlns:ITR1FORM".to_sym => "http://incometaxindiaefiling.gov.in/ITR1", "xmlns:ITR2FORM".to_sym => "http://incometaxindiaefiling.gov.in/ITR2", "xmlns:ITR3FORM".to_sym => "http://incometaxindiaefiling.gov.in/ITR3", "xmlns:ITR4FORM" => "http://incometaxindiaefiling.gov.in/ITR4", "xmlns:ITRETURN".to_sym => "http://incometaxindiaefiling.gov.in/main", "xmlns:ITRForm".to_sym => "http://incometaxindiaefiling.gov.in/master", "xmlns:xsi".to_sym => "http://www.w3.org/2001/XMLSchema-instance") {
      
      xml.tag!("ITR1FORM:ITR1") {
        
        # FormCreation Info
        xml_formcreation_info(xml)        
        # ITR1 Info
        xml_itr1_info(xml)       
        # Personal Info
        xml_personal_info(xml,@form.personal_info)        
        # Filing Status
        xml_filing_info(xml,@form.filing_info)        
        # Income and Dedution
        xml_income_and_deduction(xml,@form.income_and_deduction)        
        # Tax Computation
        xml_tax_computation(xml,@form.tax_computation)        
        # tax paid
        xml_tax_paid(xml,@form.tax_paid_and_refund)        
        # tax refund
        xml_tax_refund(xml,@form.tax_paid_and_refund)        
        #tax deduction from salary
        xml_t_dsals(xml,@form.tax_paid_and_refund)
        #tax deduction other than salaries
        xml_t_dsoths(xml,@form.tax_paid_and_refund)
        # advanced tax paid
        xml_tax_ps(xml,@form.tax_paid_and_refund)
        # AIR and Tax Exempt
        xml_air_and_tax_exempt(xml,@form.air)
        # verification
        xml_ver(xml,@form.ver,@form.personal_info)        
        # TAX Preparer
        xml_tax_preparer(xml,@form.ver)
        
               
      } #form
      
    } #return
           
    file.close
    
  end

  ## to validate xml file
  def validate(form)
    #@formid = params[:id]
    #@form = Form.find(@formid)
    @form = form
    @xml_file_name = get_xml_filename(@form)
    doc = Nokogiri::XML(File.read("#{RAILS_ROOT}/downloadfiles/#{@xml_file_name}"))
    #puts Dir.pwd
    Dir.chdir("#{RAILS_ROOT}/ITR_data/XmlSchema")
    #puts Dir.pwd    
    xsd = Nokogiri::XML::Schema(File.read("ITRMain09.xsd"))
    #puts xsd      
    xsd.validate(doc).each do |error|
      puts error.message
    end
    Dir.chdir("#{RAILS_ROOT}")
    puts Dir.pwd
  end 
  
  

end