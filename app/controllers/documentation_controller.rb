require "redis"

class DocumentationController < ApplicationController
  def index
    @docs = Machine.find(machine_id)&.documentations
  end

  def show
    @doc = Docuemntaion.find(id)
  end

  private

  def machine_id
    params[:machine_id]
  end
  def id
    params[:id]
  end
end
