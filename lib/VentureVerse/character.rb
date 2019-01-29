require 'pry'

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

  def self.new_from_vb
    self.new.tap do |character|
      Scraper.scrape_character(character).each do |k,v|
        character.send("#{k}=", v)
      end
    @@all << self
    end
  end

  def list_characters
    self.all.each.with_index(1) {|character, i| puts "#{i}. #{character.name}"}
  end
end
