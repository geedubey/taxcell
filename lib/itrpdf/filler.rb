require 'rbconfig'
require 'fileutils'
require 'tmpdir'
require 'rubygems'
require 'rjb'
include FileUtils

Rjb::load(File.join(File.dirname(__FILE__), 'iText-2.1.5.jar'), ['-Djava.awt.headless=true'])


module ITRPDF
  class Filler
    # == Example
    #
    # pdf = PDF::Stamper.new("my_template.pdf")
    # pdf.text :first_name, "Jason"
    # pdf.text :last_name, "Yates"
    # pdf.image :photo, "photo.jpg"
    # pdf.save_as "my_output"
    
    # Set a textfield defined by key and text to value.
    attr_accessor :writer
    
    def initialize(pdf = nil, options = {})
      @bytearray    = Rjb::import('java.io.ByteArrayOutputStream')
      @filestream   = Rjb::import('java.io.FileOutputStream')
      @acrofields   = Rjb::import('com.lowagie.text.pdf.AcroFields')
      @pdfreader    = Rjb::import('com.lowagie.text.pdf.PdfReader')
      @pdfstamper   = Rjb::import('com.lowagie.text.pdf.PdfStamper')
    
      template(pdf) if ! pdf.nil?
    end
  
    def template(template)
      reader = @pdfreader.new(template)
      @baos = @bytearray.new
      @stamp = @pdfstamper.new(reader, @baos)
      @form = @stamp.getAcroFields()
    end
    
    def text(key, value)
      @form.setField(key , value.to_s) # Value must be a string or itext will error.
    end
    
    # Saves the PDF into a file defined by path given.
    def save_as(file)
      f = File.new(file, "w")
      f.syswrite to_s
    end
    
    private

    def fill
      @stamp.setFormFlattening(true)
      @stamp.close
    end
  end
end
