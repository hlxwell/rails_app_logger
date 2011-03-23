require 'rubygems'
require 'anemone'

100.times do
  Anemone.crawl("http://127.0.0.1:3000") do |anemone|
    anemone.on_every_page { |page|
      puts page.url
    }
  end
end
