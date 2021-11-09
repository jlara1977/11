class Document < ApplicationRecord
  include DocumentUploader::Attachment(:document)

  belongs_to :documentable, polymorphic: true
end

# == Schema Information
#
# Table name: documents
#
#  id                :bigint(8)        not null, primary key
#  documentable_type :string           not null
#  documentable_id   :bigint(8)        not null
#  document_data     :jsonb
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_documents_on_documentable_type_and_documentable_id  (documentable_type,documentable_id)
#
