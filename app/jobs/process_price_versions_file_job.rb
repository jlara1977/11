class ProcessPriceVersionsFileJob < ApplicationJob
  queue_as :default

  def perform(file_url)
    ProcessPriceVersionsMatrixFile.for(file_url: file_url)
  end
end
