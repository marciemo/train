require 'spec_helper'

describe Station do

  context '#save' do 
    it 'saves the station name to the database' do
      station = Station.new({'name' => 'Capitol'})
      expect {station.save}.to change {Station.all.length}.by 1
    end
  end

  context '#view_lines' do
    it 'returns an array of the lines that go through the requested station' do
      station = Station.new({'name' => 'Roosevelt'}).save
      lines = ['Green', 'Blue', 'Red'].inject([]) { |lines, name| lines << Line.new({'name' => name}).save }
      lines.each { |line| Connection.new(station,line).save }
      station.view_lines.should =~ lines      
    end
  end

  context '.all' do
    it 'should start out empty' do
      Station.all.length.should eq 0
    end

    it 'returns an array of all stations from the Stations table' do
      names = ['Montgomery', 'Embarcadero', 'Powell']
      names.each {|name| Station.new({'name' => name}).save}
      Station.all.map {|station| station.name}.should =~ names
    end

  end

  context '#fetch_by_id' do
    it 'returns the line record for the given id#' do
      station = Station.new({'name' => 'Embarcadero'})
      station.save
      Station.fetch_by_id(station.id).name.should eq 'Embarcadero'
    end
  end

end