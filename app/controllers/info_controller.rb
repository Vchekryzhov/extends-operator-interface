require "redis"

class InfoController < ApplicationController
  def show

  end

  def index
    @machines = Machine.all
  end

  private

  def id
    params[:id]
  end
end
