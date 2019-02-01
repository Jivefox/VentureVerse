class Scraper

  VENTURE_URL = "https://venturebrothers.fandom.com/"

  def self.scrape_character_directory
    html = open("https://venturebrothers.fandom.com/Category:Characters")
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


  def self.scrape_character_page(character)
    html = open(VENTURE_URL + character.name.gsub(" ","_"))
    page = Nokogiri::HTML(html)
    character_details = {}
    character_details[:first_appearance] =  page.css('tr td a').map {|object| object.attr('title')}[2]
    character_details[:episodes] = page.css('ul li i').map {|object| object.text} << character_details[:first_appearance]
    character_details[:episodes].uniq
    character_details[:voice_actor] = page.css('tr td a').map {|object| object.attr('title')}[3].gsub("wikipedia:", "")
    character_details
  end

  def self.scrape_episodes
    html = open("https://venturebrothers.fandom.com/wiki/Episodes#Songs")
    page = Nokogiri::HTML(html)

    episodes = page.css('ul li i')

    episodes.map do |object|
      name = object.text
      episode = Episode.new(name)
      # episodes.pop(2)
    end
    binding.pry
  end
end
