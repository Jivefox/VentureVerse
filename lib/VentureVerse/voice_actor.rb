class VoiceActor

  attr_accessor :name, :characters, :episodes, :url

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.new_from_vb

  end

end
