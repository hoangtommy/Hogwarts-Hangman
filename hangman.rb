# Class can create instances of the game Hangman
class Game
  require './moduleDisplay.rb'
  require 'json'

  include Display

  def initialize
  	display_instructions
  	get_game_options
  	play_game
  end

  private

  def get_game_options
  	display_game_options
  	response = gets.chomp
  	response.downcase == '2' ? load_game : new_game
  end

  def load_game
  	display_get_saved_game
  	name = gets.chomp
  	filename = "saved_games/#{name.capitalize}_HogwartsHangman.rb"
  	until File.exist?(filename) do
  	  display_name_error
  	  name = gets.chomp
  	  filename = "saved_games/#{name.capitalize}_HogwartsHangman.rb"
  	end
  	set_game_files(filename)
  end

  def set_game_files(file)
  	saved_game = JSON.parse(File.read(file))
  	@guesses_left = saved_game['guesses_left']
  	@letters_used = saved_game['letters_used']
  	@word = saved_game['word']
  	@blanks_to_fill = saved_game['blanks_to_fill']
  	@game_over = saved_game['game_over']
  	@player_name = saved_game['player_name']
  end

  def new_game
  	@guesses_left = 6
  	@letters_used = []
  	@word = get_random_word
  	@blanks_to_fill = Array.new(@word.length)
  	@game_over = false

  end

  def play_game
  	until @guesses_left == 0 || @game_over
  	  display_feedback(@blanks_to_fill)
  	  guess = get_player_response

  	  if !guess_correct?(guess)
  	    display_letters_used(@letters_used)
  	    @guesses_left -= 1
  	    display_hangman(@guesses_left)
  	  end

	  end_game('won') if @blanks_to_fill.all? { |letter| !letter.nil? }
  	end
  	end_game('loss')
  end

  def guess_correct?(guess)
  	if guess == @word
  	  end_game('won')
  	elsif @word.include?(guess)
  	  @word.split('').each_with_index do |letter, idx|
  	  	next if !@blanks_to_fill[idx].nil?
  	  	@blanks_to_fill[idx] = letter if letter =~ /[\s\W]/
  	  	@blanks_to_fill[idx] = letter if guess == letter
  	  end
	  return true
  	else
  	  @letters_used << guess if guess.length == 1 && !@letters_used.include?(guess)
  	  return false
  	end
  end

  def get_player_name
  	display_get_player_name
  	name = gets.chomp
  	display_farewell(name)
  	name.capitalize
  end

  def get_random_word
    dictionary = File.open('hogwartsDictionary.txt', 'r').readlines
    word = dictionary[rand(dictionary.length)].strip.downcase
    word
  end

  def get_player_response
  	display_get_guess
  	guess = gets.chomp
  	save_game if guess.downcase == 'save'
  	until guess.length == 1 || guess.length == @word.length
  	  display_error(@word.length)
  	  guess = gets.chomp
  	end
  	guess.downcase # Tom: okay to use the same local variable name here and above?
  end

  def save_game
  	@player_name = get_player_name

  	gameFile = {
	  	:guesses_left => @guesses_left,
	  	:letters_used => @letters_used,
	    :word => @word,
	    :blanks_to_fill => @blanks_to_fill,
	  	:game_over => @game_over,
	  	:player_name => @player_name
    }

  	Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
  	filename = "saved_games/#{@player_name}_HogwartsHangman.rb"
  	File.open(filename, 'w') do |file|
  	  file.write(gameFile.to_json)
  	end
  	puts 'Your game is saved. Use your wizarding name to access it when you return.'
  	exit
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
