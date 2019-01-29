require 'pry'

class Scraper

  CHARACTERS_URL = "https://venturebrothers.fandom.com/Category:Characters"

  # def self.scrape_character_directory
  #   html = open(CHARACTERS_URL)
  #   page = Nokogirl::HTML(html)
  #
  #   characters = page.css("li.category-page_member a")
  #     # name = characters.each {|element| element.text unless element.text.include?('Category')}.compact
  #     urls = characters.map {|element| element.attr('href') unless element.text.include?('Category')}.compact
  #     urls.each {|url| Character.new_from_vb(url)}
  #     # Character.all << self.scrape_character(url)
  #   end

  # def self.list_characters
  #   html = open(CHARACTERS_URL)
  #   page = Nokogiri::HTML(html)
  #
  #   characters = page.css("li.category-page__member a").map {|element| element.text unless element.text.include?('Category')}.compact
  #     characters.each.with_index(1) {|char, i| puts "#{i}. #{char}"}
  # end
  #
  # def self.get_character_urls
  #   html = open(CHARACTERS_URL)
  #   page = Nokogiri::HTML(html)
  #
  #   character.url = page.css("li.category-page_member a").map {|element| element.attr('href') unless element.text.include?('Category')}
  # end

  def self.scrape_character
    html = open(CHARACTERS_URL)
    page = Nokogiri::HTML(html)
    character = {}
    urls = page.css("li.category-page__member a").map {|element| element.attr('href') unless element.text.include?('Category')}.compact
    character[:url] = urls.each {|url| url}
    character[:name] = character[:url].css('h1.page-header__title').text
    character[:episodes] = character[:url].css('ul li i').map {|object| object.text}
    character[:first_appearance] =  character[:url].css('tr td a').map {|object| object.attr('title')}[2]
    character[:voice_actor] = character[:url].css('tr td a').map {|object| object.attr('title')}[3].gsub("wikipedia:", "")
    character
  end

  def self.list_episodes
    html = open("https://venturebrothers.fandom.com/wiki/Episodes#Songs")
    page = Nokogiri::HTML(html)

    objects = page.css('ul li i')
    episodes = objects.map {|object| object.text}
    episodes.each.with_index(1) {|episode, i| puts "#{i}. #{episode}"}.uniq
  end
end
