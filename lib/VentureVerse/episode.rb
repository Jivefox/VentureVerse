class Episode

  attr_accessor :name, :characters, :voice_actors, :url

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  def self.new_from_vb

  end
end
