class Scraper

  VENTURE_URL = "https://venturebrothers.fandom.com"

  def self.scrape_character_directory
    html = open("https://venturebrothers.fandom.com/Category:Characters")
    page = Nokogiri::HTML(html)

    characters = page.css("li.category-page__member a")

    characters.map do |nodeset|
      name = nodeset.text
      unless nodeset.text.include?('Category') || name.match(/[^\x00-\x7F]/)
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
        name = nodeset.text
        unless nodeset.text.include?('Category')
          url = nodeset.attr('href')
          character = Character.new(name, url)
        end
      end
    end


  def self.scrape_character_page(character)
    html = open(VENTURE_URL + character.name.gsub(" ","_"))
    page = Nokogiri::HTML(html)
    character_details = {}
    page.css('table.infobox tr')[4..-1].detect do |nodeset|
      nodeset.children.find do |node|
        character_details[:voice_actor] = nodeset.children.last.text.strip if node.text.include?("Voiced by")
      end
    end
    character_details[:first_appearance] =  page.css('tr td a').map {|object| object.attr('title')}[2]
    character_details[:episodes] = page.css('ul li i').map {|object| object.text}
    character_details
  end



    def self.scrape_episode_directory
      html = open("https://venturebrothers.fandom.com/wiki/Episodes#Songs")
      page = Nokogiri::HTML(html)

      episodes = page.css('div.mw-content-ltr.mw-content-text ul li a')

      episodes.map do |object|
        name = object.text
        url = object.attr('href')
        episode = Episode.new(name, url)
      end
    end

    def self.scrape_episode_page(episode)
      # html = open(VENTURE_URL + episode.name.gsub(" ","_"))
      html = open(VENTURE_URL + episode.url)
      page = Nokogiri::HTML(html)
      episode_details = {}
      binding.pry
      if page.at('table tr:contains("Original air date")') == nil
        puts "The original air date for this episode has not been published on the site "
      episode_details[:air_date] = page.at('table tr:contains("Original air date")').text.strip.gsub("Original air date\n    \n","")
      unless page.at('table tr:contains("Original air date")') == nil
      episode_details
      binding.pry
    end
    end
