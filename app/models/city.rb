class City < ActiveRecord::Base
  has_many :companies
  has_many :wayfindings
end
