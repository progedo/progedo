class RequestsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all.order('updated_at DESC')
  end

  def user_index
    @user = current_user.email
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  def selection
    @selected = []
    @selected << Fichier.find(params[:choix_fichier])
    @request = Request.new
    @fichiers = Fichier.all
    render '/requests/new'
  end

  # GET /requests/new
  def new
    @request = Request.new
    @fichiers = Fichier.all
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)
    @request.user = current_user
    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:title, :description)
    end
end
