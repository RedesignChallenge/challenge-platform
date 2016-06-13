class SolutionsController < ApplicationController
  before_action :load_challenge
  before_action :authenticate_user!, only: [:unlike]
  before_action :load_solution, only: [:like, :unlike, :file]

  def like
    if user_signed_in?
      @solution.liked_by(current_user, vote_scope: @solution.default_like[:scope])
      respond_to do |format|
        format.html { redirect_to after_update_object_path_for(@solution) }
        format.js { render :like, locals: { partial: "#{params[:partial]}" } }
      end
    else
      cache_pending_like(@solution, { vote_scope: @solution.default_like[:scope] })
      redirect_to preview_path(class_name: 'vote')
    end
  end

  def unlike
    @solution.unliked_by(current_user, vote_scope: @solution.default_like[:scope])

    respond_to do |format|
      format.html { redirect_to after_update_object_path_for(@solution) }
      format.js { render :unlike, locals: { partial: "#{params[:partial]}" } }
    end
  end

  def file
    unless @solution.file.nil?
      file = open(@solution.file.url)
      send_file(file, type: 'application/pdf', filename: "solution_#{@solution.id}_guide.#{@solution.file.path.split('.').last}")
    end
  end

  private

  def load_solution
    @solution = Solution.find(params[:id])
    @solution_stage = @solution.solution_stage
  end
end
