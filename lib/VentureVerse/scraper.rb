require 'pry'

class Scraper



  def self.scrape_character_page
    html = open("https://venturebrothers.fandom.com/Category:Characters")
    page = Nokogiri::HTML(html)


    char_page = page.css("li.category-page__member a")
    char_list = char_page.map do  |element|
      url = element.attr('href') unless element.text.include?('Category')
      name = element.text unless element.text.include?('Category')
      character = Character.new(name, url)
    end
      char_list.compact.each.with_index(1) do |char, i|
      puts "#{i}. #{char}"
    end
  end

  def self.scrape_character_details

  end

  def self.list_episodes
    html = open("https://venturebrothers.fandom.com/wiki/Episodes#Songs")
    page = Nokogiri::HTML(html)

    objects = page.css('ul li i')
    episodes = objects.map {|object| object.text}
    episodes.each.with_index(1) {|episode, i| puts "#{i}. #{episode}"}
  end
end
