require 'csv'
require_relative 'import_data'

csv = CSV.read('./data.csv', col_sep: ';')
import_data(csv)