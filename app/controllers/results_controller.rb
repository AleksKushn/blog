class ResultsController < ApplicationController
  def index
    @search_results = PgSearch.multisearch(params[:query])
    render json: @search_results
  end
end