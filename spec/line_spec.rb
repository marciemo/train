require 'spec_helper'

describe Line do

  context '#save' do 
    it 'saves the line name to the database' do
      line = Line.new({'name' => 'Blue'})
      expect {line.save}.to change {Line.all.length}.by 1
    end
  end

  context '#view_stations' do
    it 'returns an array of the stations that occur along the requested line' do
      line = Line.new({'name' => 'Green'}).save
      stations = ['Roosevelt', 'Lincoln', 'Washington'].inject([]) { |stations, name| stations << Station.new({'name' => name}).save }
      stations.each { |station| Connection.new(station,line).save }
      line.view_stations.should =~ stations     
    end
  end


  context '.all' do
    it 'should start out empty' do
      Line.all.length.should eq 0
    end

    it 'returns an array of all lines from the Lines table' do
      names = ['Blue', 'Green', 'Red']
      names.each {|name| Line.new({'name' => name}).save}
      Line.all.map {|line| line.name}.should =~ names
    end
  end

  context '#fetch_by_id' do
    it 'returns the line record for the given id#' do
      line = Line.new({'name' => 'Blue'})
      line.save
      Line.fetch_by_id(line.id).name.should eq 'Blue'
    end
  end

end