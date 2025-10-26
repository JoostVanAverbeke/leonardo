class ObservationsController < ApplicationController
  before_action :set_order
  before_action :set_observation, only: %i[ show edit update destroy ]

  # GET /observations or /observations.json
  def index
    @observations = @order.observations.load
  end

  # GET /observations/1 or /observations/1.json
  def show
  end

  # GET /observations/new
  def new
    @observation = @order.observations.build
  end

  # GET /observations/1/edit
  def edit
  end

  # POST /observations or /observations.json
  def create
    @observation = @order.observations.create(observation_params)

    respond_to do |format|
      if @observation.save
        format.html { redirect_to @order, notice: "Observation was successfully created." }
        format.json { render :show, status: :created, location: @observation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observations/1 or /observations/1.json
  def update
    respond_to do |format|
      if @observation.update(observation_params)
        format.html { redirect_to @order, notice: "Observation was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @observation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observations/1 or /observations/1.json
  def destroy
    @observation.destroy!

    respond_to do |format|
      format.html { redirect_to order_path(@order), notice: "Observation was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:order_id])
    end

    def set_observation
      @observation = @order.observations.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def observation_params
      params.expect(observation: [ :patient_id, :order_id, :property_id, :value, :unit, :alternate_unit, :alternate_unit_coding_system, :references_, :range, :abnormal_flags, :result_status, :observation_date_time, :analysis_date_time, :observation_comment ])
    end
end
