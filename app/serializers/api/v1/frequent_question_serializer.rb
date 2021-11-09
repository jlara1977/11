class Api::V1::FrequentQuestionSerializer < ActiveModel::Serializer
  attributes :id, :question, :answer, :category
end
