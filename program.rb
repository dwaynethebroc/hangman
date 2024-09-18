class Game
  def initialize
    @guess_array = []
  end 

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

  def display_game_progress
    hangman_array = stages = ['
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
  end 

  def game_turn
    dictionary = File.readlines('lib/google-10000-english-no-swears.txt')
    get_random_word(dictionary)

    guess = ask_for_guess

  end 
end 



#make an array of dictionary


#creates the hangman password


