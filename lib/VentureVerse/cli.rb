class VentureVerse::CLI

  def call
    main_menu
    adios
  end

  def main_menu
    puts "Would you like to explore the involuted universe of the Venture Bros. via character, episode or voice actor?"
    input = nil
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
    input = gets.strip.downcase
    character = Character.all[input.to_i - 1]
    if character
      # Scraper.scrape_character_page(character)
      character_details(character)
    elsif input == "main menu"
      main_menu
    else
      invalid_character
    end
  end

  def episode_menu
    Scraper.scrape_episode_directory
    Episode.list_episodes
    puts "Enter the number of the episode with which you'd like to better familiarize yourself.  Type 'main menu' to return to main menu.  Type 'exit' if you want to, you know, exit."
      input = gets.strip.downcase
      episode = Episode.all[input.to_i - 1]
      binding.pry
      if episode
        episode_details(episode)
      elsif input == "main menu"
        main_menu
      else
        invalid_episode
      end
    end

  def episode_details(episode)
    episode_details = Scraper.scrape_episode_page(episode)
    puts "#{episode.name} aired on (air_date)"
    puts "It was the (nth) episode of the (nth) season"
  end

  def character_details(character)
    character_details = Scraper.scrape_character_page(character)
    puts "#{character.name} is voiced by #{character_details[:voice_actor]} and first appeared in the episode '#{character_details[:first_appearance]}.'"
    puts "#{character.name} also appears in the following episode(s): #{character_details[:episodes].join(', ')}"
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
