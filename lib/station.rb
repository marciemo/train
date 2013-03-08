class Station
  attr_reader :name, :id
  
  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end


  def save
    @id = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;").first['id']
  end

  def view_lines
    DB.exec("SELECT lines.name FROM lines, connections WHERE lines.id = connections.line_id AND #{@id} = connections.station_id;").inject([]) {|lines, lines_hash| lines << Line.new(lines_hash)}
  end

  def self.all
    DB.exec("SELECT * FROM stations;").inject([]) {|stations, station_hash| stations << Station.new(station_hash)}
  end

  # def self.search

  # end


end