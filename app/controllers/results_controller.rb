class ResultsController < ApplicationController
  load_and_authorize_resource
  def index
    @search_results = (Post.find_by_field_substring params[:query]).distinct!
    render json: @search_results
  end
end