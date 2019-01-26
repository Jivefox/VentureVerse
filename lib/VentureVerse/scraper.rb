require 'pry'

class Scraper



  def self.scrape_character_page
    html = open("https://venturebrothers.fandom.com/Category:Characters")
    page = Nokogiri::HTML(html)


    char_urls = page.css("li.category-page__member a")
    char_list = char_urls.map do  |element|
      url = element unless element.text.include?('Category')
      name = element.text unless element.text.include?('Category')
      Character.new(name, url)
      binding.pry
    end
      char_list.compact.each.with_index(1) do |char, i|
      puts "#{i}. #{char}"
    end
  end
end
