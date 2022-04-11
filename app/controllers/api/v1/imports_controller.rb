class Api::V1::ImportsController < ApplicationController
  def create
    @import = current_admin.imports.create!(file: permitted_params[:file])

    render json: @import, status: :created
  end

  private

  def permitted_params
    params.require(:import).permit(:file)
  end
end
