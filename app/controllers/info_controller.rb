require "redis"

class InfoController < ApplicationController
  def show
    machine = Machine.find(id)
    @machine = machine
  end

  def index
    @machines = Machine.all.order(position: :desc)
  end

  private

  def id
    params[:id]
  end
end
