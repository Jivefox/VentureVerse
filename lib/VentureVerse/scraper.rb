require 'pry'

class Scraper

  CHARACTERS_URL = "https://venturebrothers.fandom.com/Category:Characters"

  def self.scrape_character_directory
    html = open(CHARACTERS_URL)
    page = Nokogiri::HTML(html)

    characters = page.css("li.category-page__member a")

    characters.map do |nodeset|
      character_hash = {}
      unless nodeset.text.include?('Category')
        character_hash[:name] = nodeset.text
        character_hash[:url] = nodeset.attr('href')
        Character.all << character_hash
      end
    end
  end



      # characters = page.css("li.category-page__member a")
      # # names = characters.map {|element| element.text unless element.text.include?('Category')}.compact #Array of names
      # # urls = characters.map {|element| element.attr('href') unless element.text.include?('Category')}.compact #Array of urls
      #
      # elements = characters.each {|element| element}
      # url = elements.attr('href') unless elements.text.include?('Category')
      # name = elements.text unless elements.text.include?('Category')
      # Character.new(name, url)
      # # urls.each {|url| character_hash[:url] = url[2]} #I want to iterate over the array of urls and assign each url to a value of :url in character_hash
      # # names.each {|name| character_hash[:name] = name[2]} # Same here but for names
      #  #It seems to be working, but only for the last instance of url and name.  I imagine it is a problem with .each, but I don't know what to use instead.  When I change it to .map, I get the same return.
      # Character.all
      # binding.pry

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

  # def self.scrape_character
  #   html = open(CHARACTERS_URL)
  #   page = Nokogiri::HTML(html)
  #   character = {}
  #   urls = page.css("li.category-page__member a").map {|element| element.attr('href') unless element.text.include?('Category')}.compact
  #   binding.pry
  #   character[:url] = urls.each {|url| url}
  #   character[:name] = character[:url].css('h1.page-header__title').text
  #   character[:episodes] = character[:url].css('ul li i').map {|object| object.text}
  #   character[:first_appearance] =  character[:url].css('tr td a').map {|object| object.attr('title')}[2]
  #   character[:voice_actor] = character[:url].css('tr td a').map {|object| object.attr('title')}[3].gsub("wikipedia:", "")
  #   character
  # end

  def self.list_episodes
    html = open("https://venturebrothers.fandom.com/wiki/Episodes#Songs")
    page = Nokogiri::HTML(html)

    objects = page.css('ul li i')
    episodes = objects.map {|object| object.text}
    episodes.each.with_index(1) {|episode, i| puts "#{i}. #{episode}"}.uniq
  end
end
