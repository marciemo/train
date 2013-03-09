require 'pg'
require 'rspec'
require 'connection'
require 'line'
require 'station'

DB = PG.connect(:dbname => 'timetable_test', :host => 'localhost')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM connections *;")
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM stations *;")
  end
end