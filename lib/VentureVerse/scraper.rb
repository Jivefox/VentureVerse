require 'pry'

class Scraper

  CHARACTER_PAGE = "https://venturebrothers.fandom.com + character.url"

  def self.get_characters
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

  def self.scrape_character
    html = open("https://venturebrothers.fandom.com/Category:Characters")
    page = Nokogiri::HTML(html)
    character = {}
    character[:name] = page.css('h1.page-header__title').text
    character[:episodes] = page.css('ul li i').map {|object| object.text}
    character[:first_appearance] =  page.css('tr td a').map {|object| object.attr('title')}[2]
    character[:voiced_by] = page.css('tr td a').map {|object| object.attr('title')}[3].gsub("wikipedia:", "")
    character
  end

  def self.list_episodes
    html = open("https://venturebrothers.fandom.com/wiki/Episodes#Songs")
    page = Nokogiri::HTML(html)

    objects = page.css('ul li i')
    episodes = objects.map {|object| object.text}
    episodes.each.with_index(1) {|episode, i| puts "#{i}. #{episode}"}
  end
end
