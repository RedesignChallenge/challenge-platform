require 'csv'
require 'open-uri'

import_bucket = []
total_imported = 0

if %w(local staging).include?(ENV['DEPLOY_REMOTE'])
  file = Rails.root.join('db', 'seeds', 'seed_data', 'states.txt')
else
  file = 'http://challengeplatform.mobility-labs.com/states.txt'
end

CSV.foreach(open(file), headers: true, col_sep: "\t", encoding: 'ISO-8859-1') do |row|
  state = State.new
  import = row.to_hash

  state.fipst = import['FIPST']
  state.name = import['SEANAME'].titleize

  state.mail_street = import['STREET'].titleize
  state.mail_city = import['CITY'].titleize
  state.mail_state = import['STNAME']
  state.mail_zip = import['ZIP']
  state.mail_zip4 = import['ZIP4']
  state.phone = import['PHONE']

  state.number_of_members = import['MEMBER']

  import_bucket << state
end

State.transaction do
  import_bucket.each do |state|
    state.save!
    puts "-- Finished importing #{state.name}"
  end

  total_imported += import_bucket.length
end

puts "Finished importing #{total_imported} states"