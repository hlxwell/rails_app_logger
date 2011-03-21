require 'rubygems'
require 'anemone'

  Anemone.crawl("http://lvh.me:8080") do |anemone|
    anemone.on_every_page { |page|
      puts page.url
    }
  end
