class Node::NodePreviewSerializer < BaseSerializer
  attributes :title, :image, :preview_description, :depart_name, :online?, :last_online, :additional
  def depart_name
    object.departments.first&.name
  end
  def additional
    [
      [:test, "OPC CNC COLLECT tratatat"],
      [:test2, "OPC CNC COLLECT tratatat"],
      [:test3, "OPC CNC COLLECT tratatat"],
      [:test4, "OPC CNC COLLECT tratatat"],
    ]
  end
end
