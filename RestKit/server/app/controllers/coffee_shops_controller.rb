class CoffeeShopsController < ApplicationController
  before_action :set_coffee_shop, only: [:show, :edit, :update, :destroy]

  # GET /coffee_shops
  # GET /coffee_shops.json
  def index
    @coffee_shops = CoffeeShop.all
    respond_to do |format|
      format.html { render }
      format.json { render json: @coffee_shops }
    end
  end

  # GET /coffee_shops/1
  # GET /coffee_shops/1.json
  def show
    respond_to do |format|
      format.html { render }
      format.json { render json: @coffee_shop }
    end
  end

  # GET /coffee_shops/new
  def new
    @coffee_shop = CoffeeShop.new
  end

  # GET /coffee_shops/1/edit
  def edit
  end

  # POST /coffee_shops
  # POST /coffee_shops.json
  def create
    @coffee_shop = CoffeeShop.new(coffee_shop_params)

    respond_to do |format|
      if @coffee_shop.save
        format.html { redirect_to @coffee_shop, notice: 'Coffee shop was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coffee_shop }
      else
        format.html { render action: 'new' }
        format.json { render json: @coffee_shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coffee_shops/1
  # PATCH/PUT /coffee_shops/1.json
  def update
    respond_to do |format|
      if @coffee_shop.update(coffee_shop_params)
        format.html { redirect_to @coffee_shop, notice: 'Coffee shop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coffee_shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coffee_shops/1
  # DELETE /coffee_shops/1.json
  def destroy
    @coffee_shop.destroy
    respond_to do |format|
      format.html { redirect_to coffee_shops_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coffee_shop
      @coffee_shop = CoffeeShop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coffee_shop_params
      params.require(:coffee_shop).permit(:name, :latitude, :longitude)
    end
end
