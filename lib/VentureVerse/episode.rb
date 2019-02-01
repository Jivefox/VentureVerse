class Episode

  attr_accessor :name, :characters, :voice_actors, :url

  @@all = []

  def initialize(name)
    @name = name
    # @url = url
    @@all << self
  end

  def self.all
    @@all.pop(2)
  end

  def self.new_from_vb

  end

  def self.list_episodes
    # self.all.each.with_index(1) {|episode| puts "#{i}. #{episode[:name]}"}
    self.all.each.with_index(1) {|episode, i| puts "#{i}. #{episode}"}
  end
end
