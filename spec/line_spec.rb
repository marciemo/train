require 'spec_helper'

describe Line do

  context '#save' do 
    it 'saves the line name to the database' do
      line = Line.new({'name' => 'Blue'})
      expect {line.save}.to change {Line.all.length}.by 1
    end
  end

  # context '#add' do 

  # end

  context '#view_stations' do
    it 'returns an array of the stations that occur along the requested line'
      # line = Line.new({'name' => 'Green'})

      # line.view_stations.should 


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

  # context '.search' do

  # end

end