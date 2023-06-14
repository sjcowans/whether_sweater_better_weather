class SearchFacade
  def initialize(params)
    @city = params[:location]
    @origin = params[:origin]
    @destination = params[:destination]
  end

  def city_search(city = nil)
    if city == nil
      city = @city
    end
    coordinates = MapquestService.city_coordinates(city)
    if coordinates[:results][0][:locations][0]
      coordinates[:results][0][:locations][0][:latLng]
    else 
      false
    end
  end

  def books_search
    BooksService.search_books(@city)
  end

  def road_trip
    travel_time = MapquestService.travel_time(@origin, @destination)
    if travel_time[:route][:routeError]
      if travel_time[:route][:routeError][:errorCode] == 2
        "impossible"
      else
        false
      end      
    else
      travel_time = travel_time[:route][:time]
      arrival_time = Time.now + travel_time.to_i
      {travel_time: arrival_time + convert_time(@origin, @destination)}
    end
  end

  def convert_time(origin, destination)
    origin_coords = MapquestService.city_coordinates(origin)[:results][0][:locations][0][:latLng]
    destination_coords = MapquestService.city_coordinates(destination)[:results][0][:locations][0][:latLng]
    origin_time = Timezone.lookup(origin_coords[:lat], origin_coords[:lng])
    destination_time = Timezone.lookup(destination_coords[:lat], destination_coords[:lng])
    destination_time.utc_to_local(Time.now) - origin_time.utc_to_local(Time.now)
  end
end