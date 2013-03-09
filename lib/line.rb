class Line
  
  attr_reader :name, :id
  
  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end


  def save
    @id = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;").first['id']
    self
  end

  def view_stations 
    DB.exec("SELECT stations.name FROM stations, connections WHERE stations.id = connections.station_id AND #{@id} = connections.line_id;").inject([]) {|stations, station_hash| stations << Station.new(station_hash)}
  end

  def self.all
    DB.exec("SELECT * FROM lines;").inject([]) {|lines, line_hash| lines << Line.new(line_hash)}
  end

  def self.fetch_by_id(id)
    line_hash = DB.exec("SELECT * FROM lines WHERE id = #{id}").first
    Line.new(line_hash)
  end

  def ==(other)
    if other.class != self.class
      false
    else
      self.name == other.name
    end
  end

end