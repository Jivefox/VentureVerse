require 'pry'

class Character

  attr_accessor :name, :episodes, :voice_actor, :first_appearance, :url

  @@all = []

  def initialize
    @@ll << self
  end

  def self.all
    @@all
  end

  def self.new_from_vb
    self.new.tap do |character|
      Scraper.scrape_character.each do |k,v|
        character.send("#{k}=", v)
      end
    end
  end

  def self.list_characters
    self.all.each.with_index(1) {|character, i| puts "#{i}. #{character[:name]}"}
  end
end
