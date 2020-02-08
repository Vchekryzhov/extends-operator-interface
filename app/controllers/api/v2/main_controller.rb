class Api::V2::MainController < ApiController
  def index
    result = {}
    result[:nodes] = ActiveModelSerializers::SerializableResource.new(
      Node.includes(:departments).all,
      each_serializer: Node::NodePreviewSerializer
    )
    render json: result
  end
end
