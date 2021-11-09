class Api::V1::DocumentSerializer < ActiveModel::Serializer
  attributes :id, :documentable, :document_url
end
