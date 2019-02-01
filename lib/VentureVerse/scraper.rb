class Scraper

  CHARACTERS_URL = "https://venturebrothers.fandom.com/Category:Characters"

  def self.scrape_character_directory
    html = open(CHARACTERS_URL)
    page = Nokogiri::HTML(html)

    characters = page.css("li.category-page__member a")

    characters.map do |nodeset|
      unless nodeset.text.include?('Category')
        name = nodeset.text
        url = nodeset.attr('href')
        character = Character.new(name, url)
      end
    end
  end

    def self.scrape_character_directory_2
      html = open("https://venturebrothers.fandom.com/Category:Characters?from=Manotaur")
      page = Nokogiri::HTML(html)

      characters = page.css("li.category-page__member a")

      characters.map do |nodeset|
        unless nodeset.text.include?('Category')
          name = nodeset.text
          url = nodeset.attr('href')
          character = Character.new(name, url)
        end
      end
    end


  # def self.scrape_character_page(character)
  #   html = open(CHARACTERS_URL + character.url)
  #   page = Nokogiri::HTML(html)
  #   character = {}
  #   urls = page.css("li.category-page__member a").map {|element| element.attr('href') unless element.text.include?('Category')}.compact
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
    episodes.pop(2)
    episodes.each.with_index(1) {|episode, i| puts "#{i}. #{episode}"}
  end
end
