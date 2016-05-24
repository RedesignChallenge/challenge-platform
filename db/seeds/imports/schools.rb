# This variable can be set to "small" to reduce the seed time
seed_task = 'small' if ['local', 'staging'].include?(ENV['DEPLOY_REMOTE'])

require 'csv'
require 'open-uri'

import_bucket = []
total_imported = 0

CSV.foreach(open("https://s3.amazonaws.com/pdc-dev-seeds/schools.txt"), headers: true, col_sep: "\t", encoding: "ISO-8859-1") do |row|
  school = School.new
  import = row.to_hash
  
  school.nces_id = import['NCESSCH']
  school.fipst = import['FIPST']
  school.lea_id = import['LEAID']
  school.school_id = import['SCHNO']

  school.stid = import['STID']
  school.sea_school_id = import['SEASCH']
  school.lea_name = import['LEANM'].titleize

  school.name = import['SCHNAM'].titleize
  school.phone = import['PHONE']

  school.mail_street = import['MSTREE'].titleize
  school.mail_city = import['MCITY'].titleize
  school.mail_state = import['MSTATE']
  school.mail_zip = import['MZIP']
  school.mail_zip4 = import['MZIP4']

  school.location_street = import['LSTREE'].titleize
  school.location_city = import['LCITY'].titleize
  school.location_state = import['LSTATE']
  school.location_zip = import['LZIP']
  school.location_zip4 = import['LZIP4']

  school._type = import['TYPE']
  school.status = import['STATUS']

  school.ulocal = import['ULOCAL']
  school.latitude = import['LATCOD']
  school.longitude = import['LONCOD']
  school.county_number = import['CONUM']
  school.county_name = import['CONAME'].titleize
  school.cdcode = import['CDCODE']

  school.ft_teachers = import['FTE']
  school.lowest_grade = import['GSLO']
  school.highest_grade = import['GSHI']
  school.level = import['LEVEL']
  school.title1 = import['TITLEI']
  school.stitle1 = import['STITLI']
  school.magnet = import['MAGNET']
  school.charter = import['CHARTR']
  school.shared = import['SHARED']
  school.bies = import['BIES']

  import_bucket << school

  # We need these first 1000 schools or schools_spec test will fail
  if seed_task == 'small' && import_bucket.length >= 100
    puts "- finished small import"
    break
  end
end

School.transaction do
  import_bucket.each do |s|
    s.save!
    puts "-- Finished importing #{s.name}"
  end

  total_imported += import_bucket.length
end

puts "Finished importing #{total_imported} schools"