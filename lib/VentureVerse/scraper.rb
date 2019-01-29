require 'pry'

class Scraper

  CHARACTERS_URL = "https://venturebrothers.fandom.com"

  def self.list_characters
    html = open("https://venturebrothers.fandom.com/Category:Characters")
    page = Nokogiri::HTML(html)

    characters = page.css("li.category-page__member a").map {|element| element.text unless element.text.include?('Category')}.compact
      # character.url = element.attr('href') unless element.text.include?('Category') make get_character_page method for this
      characters.each.with_index(1) {|char, i| puts "#{i}. #{char}"}
  end

  def self.scrape_character
    html = open("CHARACTERS_URL + character.url")
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
