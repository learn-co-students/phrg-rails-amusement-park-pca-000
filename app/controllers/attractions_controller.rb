class AttractionsController <ApplicationController

  def index
    @attractions = Attraction.all
    @user = User.find_by_id(session[:user_id])
    # binding.pry
  end

  def new
    @attraction = Attraction.new
  end

  def create
    # binding.pry
    attraction = Attraction.create(name: params[:attraction][:name], min_height: params[:attraction][:min_height], happiness_rating: params[:attraction][:happiness_rating], nausea_rating: params[:attraction][:nausea_rating], tickets: params[:attraction][:tickets])
    redirect_to attraction_path(attraction)
  end

  def show
    @attraction = Attraction.find_by_id(params[:id])
    @user = User.find_by_id(session[:user_id])
    @ride = Ride.create(user_id: @user.id, attraction_id: @attraction.id)
    # binding.pry
  end

  def edit
    @attraction = Attraction.find_by_id(params[:id])
  end

  def update
    @attraction = Attraction.find_by_id(params[:id])
    @attraction.update(name: params[:attraction][:name])
    redirect_to attraction_path(@attraction)
  end
end
