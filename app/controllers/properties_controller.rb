class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @properties = current_user.properties
  end

  def show
    @photos = @property.photos
  end

  def new
    @property = current_user.properties.build
  end

  def create
    @property = current_user.properties.build(property_params)

    if @property.save

      if params[:images]
        params[:images].each do |image|
          @property.photos.create(image: image)
        end
      end

      @photos = @property.photos
      redirect_to edit_property_path(@property), notice: "Saved..."
    else
      render :new
    end
  end

  def edit
    if current_user.id == @property.user.id
      @photos = @property.photos
    else
      redirect_to root_path, notice: "You don't have permission."
    end
  end

  def update
    if @property.update(property_params)

      if params[:images]
        params[:images].each do |image|
          @property.photos.create(image: image)
        end
      end

      redirect_to edit_property_path(@property), notice: "Updated..."
    else
      render :edit
    end
  end

  private
    def set_property
      @property = Property.find(params[:id])
    end

    def property_params
      params.require(:property).permit(:property_type, :room, :accommodate, :bedroom, :bathroom, :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_ac, :is_heating, :is_internet, :is_furnished, :is_workspace, :is_dishwasher, :is_pet_allowed, :is_parking, :is_doorman, :is_roof_access, :is_gym, :is_pool, :price,
      :square_foot, :washer, :active)
    end
end
