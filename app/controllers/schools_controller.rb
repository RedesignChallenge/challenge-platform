class SchoolsController < ApplicationController
  
  def search
    @schools = School.search(params[:search])

    respond_to do |format|
      format.html { }
      format.json { render json: @schools, each_serializer: SchoolSerializer }
    end
  end
end
