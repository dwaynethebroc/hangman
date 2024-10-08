class Game

  def initialize
    @dictionary = File.readlines('lib/google-10000-english-no-swears.txt')
    @hangman_password = get_random_word(@dictionary)
    @guess_array = Array.new() 
    @incorrect_guesses = 0
    @array_of_correct_guesses = Array.new(@hangman_password.size, "_")
    @hangman_array = @hangman_password.split('')
    @game_win = false
  end 

  #save game method

  #load save game method 

  def get_random_word(dictionary)
    dictionary_array = dictionary.map(&:strip)

    hangman_password = ""
    until hangman_password.length.between?(5, 12)
      hangman_password = dictionary_array.sample.strip
    end 

    hangman_password
  end 

  def ask_for_guess
    guess = ""

    until guess =~ /^[a-z]+/  
      puts "please enter a letter you have not already guessed"
      guess = gets.chomp
    end 

    if @guess_array.include?(guess)
      puts "You have already guessed this letter. Please enter another letter"
      ask_for_guess
    else
      guess
    end
  end

  def compare_guess_to_word(player_guess, hangman_password)
    if hangman_password.include?(player_guess)
      true
    else
      false
    end 
  end 

  def display_game_progress(incorrect_guesses, guess_array)
        stickfigure_array = ['
        ------
        |    |
        |
        |
        |
        |
        |
    ------------
    ', '
        ------
        |    |
        |    O
        |
        |
        |
        |
    ------------
    ', '
        ------
        |    |
        |    O
        |    |
        |    |
        |
        |
    ------------
    ', '
        ------
        |    |
        |    O
        |    |
        |    |
        |   /
        |
    ------------
    ', '
        ------
        |    |
        |    O
        |    |
        |    |
        |   / \
        |
    ------------
    ', '
        ------
        |    |
        |    O
        |  --|
        |    |
        |   / \
        |
    ------------
    ', '
        ------
        |    |
        |    O
        |  --|--
        |    |
        |   / \
        |
    ------------
    ']

    puts stickfigure_array[incorrect_guesses]
    puts "--------------------------------- \n"

    puts "Scoreboard: \n"
    puts guess_array.join(' ')
    puts "\n"
  end 

  def check_win_condition(array_of_correct_guesses, hangman_array)
    if !array_of_correct_guesses.include?('-') && array_of_correct_guesses.sort == hangman_array.sort
      true
    else
      false
    end 
  end 

  def game_restart
    input = ""

    until input =~ /^[ny]+/  
      puts "please enter 'y' or 'n' to reset game"
      input = gets.chomp
    end 

    if input == 'y'
      puts "Ok game restarting"
      initialize()
      puts "New game started!\n \n"
      game_turn()
    else
      puts "Thanks for playing!"
      false
    end 
  end 

  def game_turn

    until @incorrect_guesses == 6
      guess = ask_for_guess()

      if compare_guess_to_word(guess, @hangman_password)
        @guess_array.push(guess)

        @hangman_array.each_with_index do |letter, i|
          if @hangman_array[i] == guess
            @array_of_correct_guesses[i] = letter
          end 
        end 

      else 
        @incorrect_guesses += 1
      end 

      display_game_progress(@incorrect_guesses, @array_of_correct_guesses)

      #check for win condition 
      if check_win_condition(@array_of_correct_guesses, @hangman_array)
        @game_win = true
        break 
      end 
    end 
    
    if @game_win
      puts "You Win!"
    else
      puts "Game Over. You lost!"
      puts "\n"
      puts "Correct word: #{@hangman_password}"
      puts "\n"
    end

    game_restart()
  end 
end 

stickfigure = Game.new
stickfigure.game_turn

