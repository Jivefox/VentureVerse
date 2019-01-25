class character

  attr_accessor :name, :episodes, :voice_actor

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    self << @@all
  end

  def self.all
    @@all
  end

  def list_characters
    self.all.each.with_index(1) {|character, i| puts "#{i}. #{character.name}"}
  end

end
