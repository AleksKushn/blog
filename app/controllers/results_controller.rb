class ResultsController < ApplicationController
  def index
    @search_results = (Post.find_by_field_substring params[:query]).distinct!
    render json: @search_results
  end
end