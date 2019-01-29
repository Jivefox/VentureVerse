require 'pry'

class Character

  attr_accessor :name, :episodes, :voice_actor, :first_appearance, :url

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
  end

  def self.all
    @@all
  end

  def self.new_from_vb(url)
    self.new.tap do |character|
      Scraper.scrape_character(url).each do |k,v|
        character.send("#{k}=", v)
        @@all << self
      end
    end
  end

  def self.list_characters
    self.all.each.with_index(1) {|character, i| puts "#{i}. #{character[:name]}"}
    # self.all.each.with_index(1) {|character, i| puts "#{i}. #{character.name}"}
  end
end
