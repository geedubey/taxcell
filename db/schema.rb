# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090702173431) do

  create_table "airs", :force => true do |t|
    t.decimal  "code001",                     :precision => 16, :scale => 2
    t.decimal  "code002",                     :precision => 16, :scale => 2
    t.decimal  "code003",                     :precision => 16, :scale => 2
    t.decimal  "code004",                     :precision => 16, :scale => 2
    t.decimal  "code005",                     :precision => 16, :scale => 2
    t.decimal  "code006",                     :precision => 16, :scale => 2
    t.decimal  "code007",                     :precision => 16, :scale => 2
    t.decimal  "code008",                     :precision => 16, :scale => 2
    t.integer  "taxExmpIntInc", :limit => 10, :precision => 10, :scale => 0
    t.integer  "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filing_infos", :force => true do |t|
    t.string   "desigOfficerWardorCircle"
    t.integer  "returnFileSec1"
    t.string   "returnType1"
    t.date     "origRetFileDate"
    t.string   "receiptNo"
    t.string   "residentialStatus1"
    t.integer  "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", :force => true do |t|
    t.string   "formName"
    t.string   "formType"
    t.string   "year"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "income_and_deductions", :force => true do |t|
    t.decimal  "incomeFromSal",          :precision => 16, :scale => 2
    t.decimal  "famPension",             :precision => 16, :scale => 2
    t.decimal  "indInterest",            :precision => 16, :scale => 2
    t.decimal  "incomeFromOS",           :precision => 16, :scale => 2
    t.decimal  "grossTotIncome",         :precision => 16, :scale => 2
    t.decimal  "totalChapVIADeductions", :precision => 16, :scale => 2
    t.decimal  "totalIncome",            :precision => 16, :scale => 2
    t.decimal  "aggregateIncome",        :precision => 16, :scale => 2
    t.decimal  "section80C",             :precision => 16, :scale => 2
    t.decimal  "section80CCC",           :precision => 16, :scale => 2
    t.decimal  "section80CCD",           :precision => 16, :scale => 2
    t.decimal  "section80D",             :precision => 16, :scale => 2
    t.decimal  "section80DD",            :precision => 16, :scale => 2
    t.decimal  "section80DDB",           :precision => 16, :scale => 2
    t.decimal  "section80E",             :precision => 16, :scale => 2
    t.decimal  "section80G",             :precision => 16, :scale => 2
    t.decimal  "section80GG",            :precision => 16, :scale => 2
    t.decimal  "section80GGA",           :precision => 16, :scale => 2
    t.decimal  "section80GGC",           :precision => 16, :scale => 2
    t.decimal  "section80U",             :precision => 16, :scale => 2
    t.decimal  "netAgriculturalIncome",  :precision => 16, :scale => 2
    t.integer  "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personal_infos", :force => true do |t|
    t.string   "firstName"
    t.string   "middleName"
    t.string   "surNameOrOrgName"
    t.string   "pan"
    t.string   "residenceName"
    t.string   "residenceNo"
    t.string   "status"
    t.string   "localityOrArea"
    t.string   "roadOrStreet"
    t.date     "dob"
    t.string   "cityOrTownOrDistrict"
    t.string   "gender1"
    t.integer  "pinCode"
    t.integer  "stateCode1"
    t.string   "emailAddress"
    t.string   "employerCategory1"
    t.integer  "phoneNo"
    t.integer  "stdCode"
    t.integer  "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "t_dsals", :force => true do |t|
    t.string   "tan"
    t.string   "utn"
    t.string   "employerOrDeductorOrCollecterName"
    t.string   "addrDetail"
    t.string   "cityOrTownOrDistrict"
    t.integer  "pinCode"
    t.string   "stateCode"
    t.decimal  "incChrgSal",                        :precision => 16, :scale => 2
    t.decimal  "deductUnderChapVIA",                :precision => 16, :scale => 2
    t.decimal  "taxPayIncluSurchEdnCes",            :precision => 16, :scale => 2
    t.decimal  "totalTDSSal",                       :precision => 16, :scale => 2
    t.decimal  "taxPayRefund",                      :precision => 16, :scale => 2
    t.integer  "tax_paid_and_refund_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "t_dsoths", :force => true do |t|
    t.string   "tan"
    t.string   "utn"
    t.string   "employerOrDeductorOrCollecterName"
    t.string   "addrDetail"
    t.string   "cityOrTownOrDistrict"
    t.integer  "pinCode"
    t.string   "stateCode"
    t.decimal  "amtPaid",                           :precision => 16, :scale => 2
    t.date     "datePayCred"
    t.decimal  "totTDSOnAmtPaid",                   :precision => 16, :scale => 2
    t.decimal  "claimOutOfTotTDSOnAmtPaid",         :precision => 16, :scale => 2
    t.integer  "tax_paid_and_refund_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tax_computations", :force => true do |t|
    t.decimal  "section89",             :precision => 16, :scale => 2
    t.decimal  "section90and91",        :precision => 16, :scale => 2
    t.decimal  "rebateOnAgriInc",       :precision => 16, :scale => 2
    t.decimal  "taxOnAggregateInc",     :precision => 16, :scale => 2
    t.decimal  "totalTaxPayable",       :precision => 16, :scale => 2
    t.decimal  "surchargeOnTaxPayable", :precision => 16, :scale => 2
    t.decimal  "educationCess",         :precision => 16, :scale => 2
    t.decimal  "netTaxLiability",       :precision => 16, :scale => 2
    t.decimal  "grossTaxLiability",     :precision => 16, :scale => 2
    t.decimal  "totalIntrstPay",        :precision => 16, :scale => 2
    t.decimal  "totTaxPlusIntrstPay",   :precision => 16, :scale => 2
    t.decimal  "intrstPayUs234A",       :precision => 16, :scale => 2
    t.decimal  "intrstPayUs234B",       :precision => 16, :scale => 2
    t.decimal  "intrstPayUs234C",       :precision => 16, :scale => 2
    t.integer  "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tax_paid_and_refunds", :force => true do |t|
    t.decimal  "totalTaxesPaid",    :precision => 16, :scale => 2
    t.decimal  "balTaxPayable",     :precision => 16, :scale => 2
    t.decimal  "refundDue",         :precision => 16, :scale => 2
    t.decimal  "advanceTax",        :precision => 16, :scale => 2
    t.decimal  "tds",               :precision => 16, :scale => 2
    t.decimal  "selfAssessmentTax", :precision => 16, :scale => 2
    t.string   "bankAccountNumber"
    t.string   "ecsRequired"
    t.string   "bankAccountType"
    t.string   "micrCode"
    t.integer  "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tax_ps", :force => true do |t|
    t.string   "nameOfBank"
    t.string   "nameOfBranch"
    t.integer  "bsrCode"
    t.date     "dateDep"
    t.integer  "srlNoOfChaln"
    t.decimal  "amt",                    :precision => 16, :scale => 2
    t.integer  "tax_paid_and_refund_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "password_reset_code",       :limit => 40
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "vers", :force => true do |t|
    t.string   "assesseeVerName"
    t.string   "fatherName"
    t.string   "place"
    t.date     "date"
    t.string   "identificationNoOfTRP"
    t.string   "nameOfTRP"
    t.decimal  "reImbFrmGov",           :precision => 16, :scale => 2
    t.integer  "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
