require 'sidekiq'
require 'json'
require_relative 'import_data'

class Importer
  include Sidekiq::Worker

  def perform(csv)
    import_data(JSON.parse(csv))
  end    
end
