require 'pg'
require 'rspec'
require './lib/stop'
require './lib/line'
require './lib/station'


DB = PG.connect(:dbname => 'timetable', :host => 'localhost')

def welcome
  puts "Welcome to the Train System."
  main_menu
end

def main_menu
  choice = nil
  until choice == 'x'
    puts "Press 'a' to add, 'v' to view, 'x' to exit"
    choice = gets.chomp
    case choice 
    when 'a'
      add_menu
    when 'v'
      view_menu
    when 'x'
      exit
    else
      invalid
    end
  end
end

def add_menu
  choice = nil
  until choice == 'x'
    puts "Press 's' to add stations, 'l' to add lines, 'x' to exit"
    choice = gets.chomp
    case choice 
    when 's'
      add_stations
    when 'l'
      add_lines
    when 'x'
      exit
    else
      invalid
    end
  end
end


def view_menu
  choice = nil
  until choice == 'x'
    puts "Press 'l' to choose a line and view its stations, 's' to choose a station and view its lines, 'x' to exit"
    choice = gets.chomp
    case choice 
    when 's'
      view_lines
    when 'l'
      view_stations
    when 'x'
      exit
    else
      invalid
    end
  end
end

def add_stations
  puts "Enter the name of the station you would like to add."
  name = gets.chomp
  #check to see if station exists
  station = Station.new({'name' => name})
  station.save
end

def add_lines
  puts "Enter the name of the line you would like to add."
  name = gets.chomp
  #check to see if line exists
  line = Line.new({'name' => name})
  line.save
end

def view_stations
  all_lines = Line.all
  all_lines.each_with_index { |line, i| puts "   #{i+1}. #{line.name}"}
  puts "Enter the the number of the line you wish to view:"
  number = gets.chomp.to_i
  selected_line = all_lines[number-1]
  puts "Here are the stations that the #{selected_line.name} Line passes through:"
  selected_line.view_stations.each { |station| puts "   #{station.name}"}
end

def view_lines

end

def search #returns the object to the class

end

def invalid
 puts "Invalid entry."
end


def exit
  puts "Exiting."
end

welcome