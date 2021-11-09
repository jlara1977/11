class FrequentQuestionsController < ApplicationController
  def index
    @frequent_questions = FrequentQuestion.all
    @categories_options = EnumUtils.enum_options_for_select_in_vue(FrequentQuestion, :category)
  end
end
