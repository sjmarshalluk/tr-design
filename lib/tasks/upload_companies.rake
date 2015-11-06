

  task :upload_companies => :environment do

    require 'csv'

    csv_text = File.read('./public/seed_data/companies.csv', :encoding => 'iso-8859-1')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Company.create!(row.to_hash)
    end
  end

