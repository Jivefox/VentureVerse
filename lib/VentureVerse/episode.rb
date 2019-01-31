class Episode

  attr_accessor :name, :characters, :voice_actors, :url

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def self.new_from_vb

  end

  def self.list_episodes
    self.all.each.with_index(1) {|episode| puts "#{i}. #{episode[:name]}"}[-2]
  end
end
