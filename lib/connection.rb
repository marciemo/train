class Connection

  attr_reader :line, :station

  def initialize(station, line)
    @station = station
    @line = line
  end

  def save
    @id = DB.exec("INSERT INTO connections (line_id, station_id) VALUES (#{@line.id}, #{@station.id}) RETURNING id;").first['id']
    self
  end

  def self.all
    DB.exec("SELECT * FROM connections;").inject([]) do |connections, connection_hash| 
      station_object = Station.fetch_by_id(connection_hash['station_id'])      
      line_object = Line.fetch_by_id(connection_hash['line_id'])
      connections << Connection.new(station_object,line_object)
    end
  end

end
