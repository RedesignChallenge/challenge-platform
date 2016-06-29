require 'csv'
require 'open-uri'

import_bucket = []
total_imported = 0

if %w(local staging).include?(ENV['DEPLOY_REMOTE'])
  file = Rails.root.join('db', 'seeds', 'seed_data', 'districts.txt')
else
  file = 'http://challengeplatform.mobility-labs.com/districts.txt'
end

CSV.foreach(open(file), headers: true, col_sep: "\t", encoding: 'ISO-8859-1') do |row|
  district = District.new
  import = row.to_hash

  district.lea_id = import['LEAID']
  district.fipst = import['FIPST']

  district.stid = import['STID']
  district.name = import['NAME'].titleize
  district.phone = import['PHONE']

  district.mail_street = import['MSTREE'].titleize
  district.mail_city = import['MCITY'].titleize
  district.mail_state = import['MSTATE']
  district.mail_zip = import['MZIP']
  district.mail_zip4 = import['MZIP4']

  district.location_street = import['LSTREE'].titleize
  district.location_city = import['LCITY'].titleize
  district.location_state = import['LSTATE']
  district.location_zip = import['LZIP']
  district.location_zip4 = import['LZIP4']

  district._type = import['TYPE']
  district.union = import['UNION']
  district.county_number = import['CONUM']
  district.county_name = import['CONAME'].titleize
  
  district.csa = import['CSA']
  district.cbsa = import['CBSA']
  district.metmic = import['METMIC']
  district.ulocal = import['ULOCAL']
  district.cdcode = import['CDCODE']

  district.latitude = import['LATCOD']
  district.longitude = import['LONCOD']

  district.bound = import['BOUND']
  district.biea = import['BIEA']

  district.lowest_grade = import['GSLO']
  district.highest_grade = import['GSHI']

  district.charter = import['AGCHRT']

  district.number_of_schools = import['SCH'].to_i
  district.number_of_students = import['UG'].to_i
  district.number_of_k12s = import['PK12'].to_i
  district.number_of_members = import['MEMBER'].to_i
  district.number_of_speceds = import['SPECED'].to_i
  district.number_of_ells = import['ELL'].to_i

  import_bucket << district
end

District.transaction do
  import_bucket.each do |d|
    d.save!
    puts "-- Finished importing #{d.name}"
  end

  total_imported += import_bucket.length
end

puts "Finished importing #{total_imported} districts"