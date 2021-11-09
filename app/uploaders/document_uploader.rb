class DocumentUploader < BaseUploader
  def allowed_types
    @allowed_types ||= %w[application/pdf].freeze
  end
end
