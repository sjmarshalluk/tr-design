class Company < ActiveRecord::Base
  belongs_to :city

  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      company_hash = row.to_hash # exclude the price field
      company = Company.where(id: company_hash["id"])

      if company.count == 1
        company.first.update_attributes(company_hash)
      else
        Company.create!(company_hash)
      end # end if !product.nil?
    end # end CSV.foreach
  end # end self.import(file)
end
