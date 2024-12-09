class ResponsesController < ApplicationController
  def show
    @response = Response.find(params[:id])
  end
end
