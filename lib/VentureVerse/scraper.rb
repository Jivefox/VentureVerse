require 'pry'

class Scraper

  VENTURE_VERSE_URL = "https://venturebrothers.fandom.com"

  def self.scrape_characters
    html = open('VENTURE_VERSE_URL + character.url')
    doc = Nokogiri::HTML(html)

    doc.css()

    char_urls = page.css("li.category-page__member a")
    char_list = char_urls.map do  |element|
    url = element unless element.text.include?('Category')
    name = element.text unless element.text.include?('Category')
  end
    char_list.compact.each.with_index(1) do |char, i|
    puts "#{i}. #{char}"
  end
end
