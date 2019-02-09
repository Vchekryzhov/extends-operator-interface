require "redis"

class InfoController < ApplicationController
  def show

  end

  private

  def id
    params[:id]
  end
end
