class StatesController < ApplicationController

  def search
    @states = State.search(params[:search])

    respond_to do |format|
      format.html {}
      format.json { render json: @states, each_serializer: StateSerializer }
    end
  end
end
