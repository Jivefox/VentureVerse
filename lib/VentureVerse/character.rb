class Character

  attr_accessor :name, :episodes, :voice_actor, :first_appearance

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
    character.name = page.css('h1.page-header__title').text
    character.episodes = page.css('ul li i').map {|object| object.text}
    character.first_appearance =  page.css('tr td a').map {|object| object.attr('title')}[2]
    character.voiced by = page.css('tr td a').map {|object| object.attr('title')}[3].gsub("wikipedia:", "")
    @@all << self
  end

end
