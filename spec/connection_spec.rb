require 'spec_helper'

describe Connection do

  context '#save' do
    it 'saves the id# for line and station in the connection table' do
      station = Station.new({'name' => 'Powell'})
      station.save
      line = Line.new({'name' => 'Blue'})
      line.save
      connection = Connection.new(station, line)
      expect {connection.save}.to change {Connection.all.length}.by 1
    end
  end

  context '.all' do
    it 'returns an array of connections (line id cross-referenced to station id)' do
      station_names = ['Montgomery', 'Embarcadero', 'Powell']
      stations = station_names.inject([]) {|station_array, name| station_array << Station.new({'name' => name})}
      stations.each { |station| station.save }

      line_names = ['Blue', 'Green', 'Red']
      lines = line_names.inject([]) {|line_array, name| line_array << Line.new({'name' => name})}
      lines.each { |line| line.save }

    
      3.times { |i| Connection.new(stations[i],lines[i]).save } 

      Connection.all.map { |connection| connection.station.name }.should =~ station_names
    end
  end

end