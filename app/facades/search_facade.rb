class SearchFacade
  def initialize(params)
    @city = params[:location]
  end

  def city_search
    coordinates = CoordinateService.city_coordinates(@city)
    coordinates[:results][0][:locations][0][:latLng]
  end
end