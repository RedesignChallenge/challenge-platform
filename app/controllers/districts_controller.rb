class DistrictsController < ApplicationController

  def search
    @districts = District.search(params[:search])

    respond_to do |format|
      format.html { }
      format.json { render json: @districts, each_serializer: DistrictSerializer }
    end
  end

end
