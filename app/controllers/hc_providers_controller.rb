class HcProvidersController < ApplicationController
  before_action :set_hc_provider, only: %i[ show edit update destroy ]

  # GET /hc_providers or /hc_providers.json
  def index
    @hc_providers = HcProvider.order(:surname, :first_name).page(params[:page])
  end

  # GET /hc_providers/1 or /hc_providers/1.json
  def show
  end

  # GET /hc_providers/new
  def new
    @hc_provider = HcProvider.new
  end

  # GET /hc_providers/1/edit
  def edit
  end

  # POST /hc_providers or /hc_providers.json
  def create
    @hc_provider = HcProvider.new(hc_provider_params)

    respond_to do |format|
      if @hc_provider.save
        format.html { redirect_to @hc_provider, notice: "Hc provider was successfully created." }
        format.json { render :show, status: :created, location: @hc_provider }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hc_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hc_providers/1 or /hc_providers/1.json
  def update
    respond_to do |format|
      if @hc_provider.update(hc_provider_params)
        format.html { redirect_to @hc_provider, notice: "Hc provider was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @hc_provider }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hc_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hc_providers/1 or /hc_providers/1.json
  def destroy
    @hc_provider.destroy!

    respond_to do |format|
      format.html { redirect_to hc_providers_path, notice: "Hc provider was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hc_provider
      @hc_provider = HcProvider.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def hc_provider_params
      params.expect(hc_provider: [ :mnemonic, :first_name, :surname, :birth_date, :gender, :email, :phone, :mobile_phone, :internet, :address_line1, :address_line2, :municipality_id, :identifier, :title ])
    end
end
