class VentureVerse::CLI

  def call
    main_menu
    adios
  end

  def main_menu
    puts "Would you like to explore the involuted universe of the Venture Bros. via character, episode or voice actor?"
    while input !=  "exit"
      input = gets.strip.downcase
      case input
      when "character"
        character_menu
      when "episode"
        episode_menu
      when "voice actor"
        list_voice_actors
      else
        puts "Spanikopita!!  Sorry. If you'd like a valid response, please enter a valid command."
      end
    end
  end

  def character_menu
    Scraper.scrape_character_directory
    Scraper.scrape_character_directory_2
    Character.list_characters
    puts "Enter the number of the character with whom you would like to better familiarize yourself.  Type 'main menu' to return to main menu.  Type 'exit' if you want to, you know, exit."
    while input != "exit"
      input = gets.strip

      case input
      when (1..Character.all.length).include?(input.to_i)
        character = Character.all[input.to_i - 1]
        character
      when "main menu"
        main_menu
      else
        invalid_character
      end
    end
  end

  def episode_menu
    Scraper.list_episodes
    puts "Enter the number of the episode with which you'd like to better familiarize yourself.  Type 'main menu' to return to main menu.  Type 'exit' if you want to, you know, exit."
    while input != "exit"
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
