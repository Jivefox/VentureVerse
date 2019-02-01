
class Character

  attr_accessor :name, :episodes, :voice_actor, :first_appearance, :url

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.list_characters
    self.all.each.with_index(1) {|character, i| puts "#{i}. #{character.name}"}
  end
end
