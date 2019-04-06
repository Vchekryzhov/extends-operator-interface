require "redis"

class ReviewController < ApplicationController

  def show
    @reviews = Review.where(machine_id: machine_id)
  end

  private

  def machine_id
    params[:machine_id]
  end

  def id
    params[:id]
  end

end
