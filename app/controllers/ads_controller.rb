class AdsController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :set_ad, only: [:show, :edit, :update, :destroy] 
  before_filter :prepare_categories

  # GET /ads
  # GET /ads.json
  def index
    if params[:keywords].present?
      #@ads = Ad.where(["description LIKE :tag", {:tag => params[:keywords]}]).near(current_user, 100000, :order => "distance")
      #@ads = PgSearch.multisearch(params[:keywords]).near(current_user, 100000, :order => "distance")
      if params[:my_ads].present?
        if current_user
         @ads = Ad.where("user_id = ?", current_user.id).near(current_user, 1000000).page(params[:page]).per(1)
        else
         @ads = Ad.all.near('New York, NY, US',1000000).page(params[:page]).per(1)
        end      
       else
        if current_user
         @ads = Ad.search_ad(params[:keywords]).near(current_user, 1000000, :order => "distance").page(params[:page]).per(1)
        else
         @ads = Ad.search_ad(params[:keywords]).near('New York, NY, US', 1000000, :order => "distance").page(params[:page]).per(1)
        end
      end
     else
      if params[:my_ads].present?
        @ads = Ad.where("user_id = ?", current_user.id).near(current_user, 1000000).page(params[:page]).per(1)
      else        
        @ads = Ad.near(current_user, 100000, :order => "distance").page(params[:page]).per(1)
      end
    end
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = current_user.ads.new(ad_params)

    respond_to do |format|
      if @ad.save
        format.html { redirect_to @ad, notice: 'Ad was successfully created.' }
        format.json { render :show, status: :created, location: @ad }
      else
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params[:ad].permit!
    end

    private

   def prepare_categories
     @categories = Category.all
   end
end
