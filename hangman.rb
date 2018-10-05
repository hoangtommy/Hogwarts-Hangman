# Class can create instances of the game Hangman
class Game
  require './moduleDisplay.rb'

  include Display

  def initialize
  	display_instructions

  	@guesses_left = 6
  	@letters_used = []
  	@correct_letters = []
  	@word = get_random_word
  	@blanks_to_fill = Array.new(@word.length)
  	@game_over = false

  	play_game
  	# to-do: add resume game option later
  end

  private

  def play_game
  	display_blanks(@word)
  	until @guesses_left == 0 || @game_over
  	  # to-add: prompt user to save game and quit
  	  guess = get_player_guess # 'r'

  	  if guess_correct?(guess) 
  	    @word.split('').each_with_index do |letter, idx|
  	  	  next if !@blanks_to_fill[idx].nil?
  	  	  @blanks_to_fill[idx] = letter if letter =~ /[\s\W]/
  	  	  @blanks_to_fill[idx] = letter if guess == letter # feels redundant to check again here
  	    end
  	    display_feedback(@blanks_to_fill)
  	  else
  	    display_letters_used(@letters_used)
  	  end

	  end_game('won') if @blanks_to_fill.all? { |letter| !letter.nil? }
  	  display_hangman(@guesses_left) # also displays remaining guesses
  	  @game_over = true if @guesses_left == 0
  	  @guesses_left -= 1
  	end
  	end_game('loss')
  end

  def guess_correct?(guess) # 'r'
  	if guess == @word
  	  end_game('won')
  	elsif @word.include?(guess)
  	  @correct_letters << guess unless @correct_letters.include?(guess)
	  return true
  	else
  	  @letters_used << guess if guess.length == 1
  	  return false
  	end
  end

  def get_random_word
    dictionary = File.open('hogwartsDictionary.txt', 'r').readlines
    word = dictionary[rand(dictionary.length)].downcase
  end

  def get_player_guess
  	display_get_guess
  	guess = gets.chomp
  	until guess.length == 1 || guess.length == @word.length
  	  display_error(@word.length)
  	  guess = gets.chomp
  	end
  	guess.downcase # Tom: okay to use the same local variable name here and above?
  end

  def end_game(outcome)
  	@game_over = true
  	display_end_game(outcome, @word)
  	prompt_replay(outcome)
  end

  def prompt_replay(outcome)
  	display_replay_message(outcome)
  	response = gets.chomp
  	response.downcase
  	puts 'sorry you cant play again now'
  	exit
  end
end

n = Game.new
