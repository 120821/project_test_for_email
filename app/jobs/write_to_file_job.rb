class WriteToFileJob < ApplicationJob
  queue_as :default

  def perform(text, filename)
    File.open("#{Rails.root}/#{filename}", "w+") do |f|
      f.write(text)
    end
  end
end
