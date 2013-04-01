class SinglePlatform::Location

  attr_reader :id, :factual_id, :out_of_business, :published_at, :general, :location, :phones, :hours, :business_type
  attr_reader :menus

  def self.in_zipcode(zipcode, opts={})
    data = in_zipcode_request(zipcode, opts)
    locations = parse_locations(data)
    locations.each(&:fetch_menus) if opts[:include_menus]
    locations
  end

  def initialize(data)
    data.each do |key, value|
      instance_variable_set :"@#{key.underscore}", value
    end
  end

  def fetch_menus
    @menus = SinglePlatform::Menu.menus_for_location(self)
  end

  private

  def self.in_zipcode_request(zip_code, opts={})
    response = SinglePlatform::Request.get "/locations/search", count: 1000, q: zip_code, updatedSince: "2011-01-01"
    if response.body["total"] < 1000
      response.body["results"]
    else
      data = response.body["results"]
      (response.body["total"].to_i / 1000.0).floor.times do |i|
        data << SinglePlatform::Request.get("/locations/search", count: 1000, q: zip_code, updatedSince: "2011-01-01", page: i+1).body["results"]
      end
      data
    end
  end

  def self.parse_locations(data)
    data.map{|result| new(result) }
  end

end