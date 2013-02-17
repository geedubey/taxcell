module FilingInfosHelper
  
  ## for index.erb these three is required index.erb is for internal use direct for database
  ## method to get back section name from array to use in show.erb to user
  def filing_section
    if @filing_info.returnFileSec1 == 11
      return FilingInfo::RETURNFILE_SECTIONS.fetch(0).fetch(0)
    elsif @filing_info.returnFileSec1 == 12
      return FilingInfo::RETURNFILE_SECTIONS.fetch(1).fetch(0)
    elsif @filing_info.returnFileSec1 == 13
      return FilingInfo::RETURNFILE_SECTIONS.fetch(2).fetch(0)
    elsif @filing_info.returnFileSec1 == 14
      return FilingInfo::RETURNFILE_SECTIONS.fetch(3).fetch(0)
    else @filing_info.returnFileSec1 == 15
      return FilingInfo::RETURNFILE_SECTIONS.fetch(4).fetch(0)
    end   
  end
  
  
  ## method to get back return type name from TYPE array to use in showerb to user
  def filing_type
    if @filing_info.returnType1 == "O"
      return FilingInfo::FILING_TYPES.fetch(0).fetch(0)
    else @filing_info.returnType1 == "R"
      return FilingInfo::FILING_TYPES.fetch(1).fetch(0)    
    end   
  end
  
  ## method to get back residential status RESIDENTAIL_STATUS AoA to use in show.erb to user
  def residential_status
    if @filing_info.residentialStatus1 == "RES"
      return FilingInfo::RESIDENTIAL_STATUS.fetch(0).fetch(0)
    elseif @filing_info.residentialStatus1 == "NRI"
      return FilingInfo::RESIDENTIAL_STATUS.fetch(1).fetch(0)    
    else @filing_info.residentialStatus1 == "NOR"
      return FilingInfo::RESIDENTIAL_STATUS.fetch(2).fetch(0)  
    end   
  end
  
end