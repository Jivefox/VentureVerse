class Character

  attr_accessor :name, :episodes, :voice_actor

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

  def list_characters
    self.all.each.with_index(1) {|character, i| puts "#{i}. #{character.name}"}
  end

  def self.new_from_vb(url)
    html = open("https://venturebrothers.fandom.com/Category:Characters")
    page = Nokogiri::HTML(html)
    char.name = page.css('h1.page-header__title').text
    char.first_appearance =  page.css("")
    char.voiced by = page.css("")
    char.aliases = page.css("")
    char.occupation = page.css("")
    char.relatives = page.css("")
    char.notable_characteristics = page.css("")
    char.notable_alliances = page.css("")
    char.enemies = page.css("")
    @@all << self
  end

end
