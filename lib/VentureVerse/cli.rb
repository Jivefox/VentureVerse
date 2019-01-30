class VentureVerse::CLI

  def call
    main_menu
    adios
  end

  def main_menu
      puts "Would you like to explore the involuted universe of the Venture Bros. via character, episode or voice actor?"
      get_input
      while input != "exit"

      case input
      when input == "character"
        character_menu
      when input == "episode"
        episode_menu
      when input == "voice actor"
        list_voice_actors
      when input == "exit"
        adios
      else
        puts "Spanikopita!!  Sorry. If you'd like a valid response, please enter a valid command."
      end
    end
  end

  def character_menu
    Scraper.scrape_character_directory
    Character.list_characters
    puts "Enter the number of the character with whom you would like to better familiarize yourself.  Type 'main menu' to return to main menu.  Type 'exit' if you want to, you know, exit."
    get_input

    case input
    when (1..Character.all.length).include?(input)
      character = Character.all[input.to_i - 1]
    when "main menu"
      main_menu
    when "exit"
      adios
    else
      invalid_character
    end
  end

  def episode_menu
    Scraper.list_episodes
    puts "Enter the number of the episode with which you'd like to better familiarize yourself.  Type 'main menu' to return to main menu.  Type 'exit' if you want to, you know, exit."
    input = gets.strip

    if (1..Episode.all.length).include?(input)
      episode = Episode.all[input.to_i - 1]
      Scraper.scrape_episode(episode)
    elsif "main menu"
      main_menu
    else
      invalid_episode
    end
  end

  def get_input
    input = gets.strip.downcase
  end

  def invalid_character
    puts "Who dat?  Please enter a valid command."
    character_menu
  end

  def invalid_episode
    puts "Didn't see that one...  Please enter a valid command."
    episode_menu
  end

  def adios
    puts "Ta-ta.  And Go Team Venture!"
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
