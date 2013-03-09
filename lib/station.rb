class Station
  attr_reader :name, :id
  
  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end


  def save
    @id = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;").first['id']
    self
  end

  def view_lines
    DB.exec("SELECT lines.name FROM lines, connections WHERE lines.id = connections.line_id AND #{@id} = connections.station_id;").inject([]) {|lines, lines_hash| lines << Line.new(lines_hash)}
  end

  def self.all
    DB.exec("SELECT * FROM stations;").inject([]) {|stations, station_hash| stations << Station.new(station_hash)}
  end

  def self.fetch_by_id(id)
    station_hash = DB.exec("SELECT * FROM stations WHERE id = #{id}").first
    Station.new(station_hash)
  end

  def ==(other)
    if other.class != self.class
      false
    else
      self.name == other.name
    end
  end
end