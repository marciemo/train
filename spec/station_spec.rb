require 'spec_helper'

describe Station do

  context '#save' do 
    it 'saves the station name to the database' do
      station = Station.new({'name' => 'Capitol'})
      expect {station.save}.to change {Station.all.length}.by 1
    end
  end

  # context '#add' do 

  # end

  # context '#view_lines' do

  # end

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

  # context '.search' do

  # end

end