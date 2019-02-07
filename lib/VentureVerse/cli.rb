class VentureVerse::CLI

  def call
    Scraper.scrape_character_directory
    Scraper.scrape_character_directory_2
    Scraper.scrape_episode_directory
    puts "\nThis is VentureVerse.  Use it to learn more about 'The Venture Bros.'"
    main_menu
  end

  def main_menu
    puts "\nWould you like to explore the involuted universe of the Venture Bros. via character or episode?"
    input = gets.strip.downcase

    if input == "character"
      character_menu
    elsif input ==  "episode"
      episode_menu
    elsif input == 'exit'
      adios
    else
      invalid
    end
  end

  def character_menu
    Character.list_characters
    puts "\nEnter the number of the character with whom you would like to better familiarize yourself.  Type 'menu' to return to main menu.  Type 'exit' if you want to, you know, exit."
    input = gets.strip.downcase
    # binding.pry
    if input == "menu"
      main_menu
    elsif input == "exit"
      adios
    elsif input.match(/\d/) && input.to_i > 0 && input.to_i <= Character.all.length
      character = Character.all[input.to_i - 1]
      character_details(character)
      secondary_character_menu
    else
      invalid_character
    end
  end

  def secondary_character_menu
    puts "\nWanna go again? Have a little look-see at someone else[y/n]?."
    input = gets.strip.downcase
      if input == "y"
        character_menu
      elsif input == "n"
        main_menu
      else
      puts "\nYou only had two options.  Somehow you managed to blow it.  Please enter a valid command."
      secondary_character_menu
    end
  end

  def episode_menu
    Episode.list_episodes
    puts "\nEnter the number of the episode with which you'd like to better familiarize yourself.  Type 'menu' to return to main menu.  Type 'exit' if you want to, you know, exit."
      input = gets.strip.downcase
      episode = Episode.all[input.to_i - 1]
      if episode
        episode_details(episode)
        secondary_episode_menu
      elsif input == "menu"
        main_menu
      else
        invalid_episode
      end
    end

  def secondary_episode_menu
    puts "\nWanna go again? Have a little look-see at at different episode[y/n]?."
    input = gets.strip.downcase
      if input == "y"
        episode_menu
      elsif input == "n"
        main_menu
      else
      puts "\nYou only had two options.  Somehow you managed to blow it.  Please enter a valid command."
      secondary_episode_menu
    end
  end

  def episode_details(episode)
    episode_details = Scraper.scrape_episode_page(episode)
    puts "\n#{episode.name} aired on #{episode_details[:air_date]}."
    puts "It was the (nth) episode of the (nth) season"
  end

  def character_details(character)
    character_details = Scraper.scrape_character_page(character)
    puts "\n#{character.name} is voiced by #{character_details[:voice_actor]} and first appeared in the episode '#{character_details[:first_appearance]}.'"
    puts "#{character.name} also appears in the following episode(s): #{character_details[:episodes].join(', ')}"
  end

  def invalid_character
    puts "\nWho dat?  Please enter a valid command."
    character_menu
  end

  def invalid_episode
    puts "\nDidn't see that one...  Please enter a valid command."
    episode_menu
  end

  def invalid
    puts "\nSpanikopita!!  Sorry. If you'd like a valid response, please enter a valid command."
    main_menu
  end

  def adios
    puts "\nTa-ta.  And Go Team Venture!"
  end
end
