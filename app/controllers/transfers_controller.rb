class TransfersController < ApplicationController
  def create
    command = CreateTransfer.call(
      value: transfer_params[:value],
      source_id: transfer_params[:source_id],
      destination_id: transfer_params[:destination_id]
    )

    if command.success?
      render json: command.result
    else
      render json: { errors: map_errors(command.errors) }, status: :unprocessable_entity
    end
  end

  private

  def transfer_params
    params
      .require(:transfer)
      .permit(:value, :destination_id, :source_id)
  end
end
