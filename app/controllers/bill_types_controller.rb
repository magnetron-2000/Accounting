class BillTypesController < ApplicationController
  before_action :set_bill_type, only: [:show, :update, :destroy]

  # GET /bill_types
  def index
    @bill_types = BillType.all

    render json: @bill_types
  end

  # GET /bill_types/1
  def show
    render json: @bill_type
  end

  # POST /bill_types
  def create
    @bill_type = BillType.new(bill_type_params)

    if @bill_type.save
      render json: @bill_type, status: :created, location: @bill_type
    else
      render json: @bill_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bill_types/1
  def update
    if @bill_type.update(bill_type_params)
      render json: @bill_type
    else
      render json: @bill_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bill_types/1
  def destroy
    @bill_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill_type
      @bill_type = BillType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bill_type_params
      params.require(:bill_type).permit(:type_name, :mounth_per_for_bill)
    end
end
