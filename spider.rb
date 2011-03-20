require 'rubygems'
require 'anemone'

1000.times do
  Anemone.crawl("http://titan.tui8.com") do |anemone|
    anemone.on_every_page { |page|
      puts page.url
    }
  end
end