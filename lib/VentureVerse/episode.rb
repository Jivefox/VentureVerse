class Episode

  attr_accessor :name, :characters, :voice_actors, :url

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.list_episodes
    self.all.each.with_index(1) {|episode, i| puts "#{i}. #{episode.name}"}
  end
end
