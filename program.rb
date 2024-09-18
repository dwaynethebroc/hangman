def get_random_word(dictionary)
  dictionary_array = []
  dictionary.each {|row| dictionary_array.push(row)}

  hangman_password = dictionary_array.sample.strip

  until hangman_password.length >= 5 && hangman_password.length <= 12
    hangman_password = dictionary_array.sample.strip
  end 

  hangman_password
end 

#make an array of dictionary
dictionary = File.readlines('lib/google-10000-english-no-swears.txt')

#creates the hangman password
get_random_word(dictionary)