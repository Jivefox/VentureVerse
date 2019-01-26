require 'pry'

class VentureVerse::CLI

  def call
    Scraper.scrape_character_page
    main_menu
  end

  def main_menu
    puts "Would you like to better understand the involuted universe of the Venture Bros. via character, episode or voice-actor?"
    input = gets.strip.downcase
    case input
    when "character"
      character_menu
    when "episode"
      list_episodes
    when "voice-actor"
      list_voice_actors
    end
  end

  def character_menu
    puts "Enter the name of the character with whom you would like to better familiarize yourself or type 'list' to see a full list of characters.  Type 'main menu' to return to main menu.  Type 'exit' if you want to, you know, exit."
    input = gets.strip.downcase
    case input
    when Character.all.include?(input)
      character = input
      character_details(character)
      # Should return instace of character with hash of info scraped from web that matches input
    end
  end
end


  # def list_character_names
  #   puts "Enter the number of a character to get more info."
  #   list_characters
  #   input = gets.strip.to_i
  #   if (1..Character.all.length).include?(input)
  #     character = Character.all[input - 1]
  #     character_details(character)
  #   else
  #     invalid_character
  #     list_characters
  #   end
  # end

# end
