# Class can create instances of the game Hangman
class Game
  require './moduleDisplay.rb'

  include Display

  def initialize
  	@guesses_left = 6
  	@letters_used = []
  	@word = get_random_word

  	display_instructions
  	play_game
  	# to-do: add resume game option later
  end


  private

  def play_game
  	get_player_guess # to-do: make this method
  	display_hangman(@guesses_left)
  	display_word(@word, correctLetters) # both word & correctLetters should be arrays
  end

  def get_random_word
    dictionary = File.open('hogwarts_dictionary.txt', 'r').readlines
    word = dictionary[rand(dictionary.length)].split(', ')
  end
  
end

Game.new

# display n blank spaces for a word with n letters
# display a list showing all the letters a user has already typed

# prompt the user to type in a one letter guess OR to type in the entire word
	# if the letter exist in the word, display the letter & add it to the list of existiting guesses
	# if the letter doesn't exist in the word, draw a part of the hangman

	# if the entire word is correct, the user wins
	# if the entire word is incorrect, draw a part of the hangman

# display the remaining guesses the user has
	# once the remaining guesses is 0, the game is over, display the correct word
	# if all blank spaces 	

