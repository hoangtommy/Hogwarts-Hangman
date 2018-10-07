# These methods are all used to print things to the screen
module Display

  def display_instructions
  	puts ''
  	puts 'Welcome to Hangman: The Hogwarts Editions'
  	puts ''
  	3.times do 
  	  print '.'
  	  sleep(0.3)
  	end
  	puts ''
  	puts ''
  	puts 'Like the regular hangman, you\'ll be given a word represented by blank spaces.
  		You will have 6 guesses to figure out the word. 
  		You can guess a single letter or you can attempt to guess the entire word. 
  		If guessing the entire word, you won\'t get feedback on which letters are and aren\'t present.
  		To save the game at any time, type in \'save\''
  	puts ''
  	puts 'Press ENTER for the main menu'
  	gets
  end

  def display_game_options
  	puts ''
  	puts ''
  	puts 'Main Menu'
  	puts "Type '1' for New Game"
  	puts "Type '2' to Load Game"
  	puts ''
  end

  def display_get_saved_game
  	puts 'What\'s your wizarding name?'
  end

  def display_name_error
  	puts 'We don\'t have that name on record. Please try another name.'
  	puts ''
  end

  def display_get_player_name
  	puts 'Type in your wizarding name.'
  end

  def display_greeting(name)
  	puts "#{name} eh?"
  	puts "Not sure waht house you're from but Welcome to Ravenclaw's game room!"
  end

  def display_blanks(word)
  	word_length = word.include?(' ') ? word.length - 1 : word.length
  	puts "What's a #{word_length} letter word."
  	puts ''
  	temp = []
  	word.split('').each do |letter|
  	  letter =~ /[\s\W]/ ? temp << letter : temp << nil
  	end
  	display_feedback(temp)
  end

  def display_hangman(turns_left)
  	case(turns_left)
  	when 6
  	 puts 'You have 5 turns left'
  	when 5
  	 puts 'You only have 5 guesses left'
  	  when 4
  	 puts '4 more turns'
  	when 3
  	 puts '3 guesses remaining'
  	when 2
  	 puts '2 turns left yo'
  	when 1
  	 puts 'last try!'
  	end
  	puts ''
  	puts ''
  end

  def display_letters_used(letters)
  	puts "Letters used: #{letters.join(', ')}"
  	puts ''
  end

  def display_feedback(hidden_word) # [nil, 'a', nil, nil, 'c']
  	length = hidden_word.length
  	feedback = Array.new(length)
  	hidden_word.each_with_index do |letter, idx|
  	  if letter.nil?
  	  	feedback[idx] = '__'
  	  else
  	  	feedback[idx] = letter
  	  end
  	end
  	puts ''
  	puts feedback.join(' ')
  	puts ''
  	puts ''
  end

  def display_get_guess
  	puts ''
  	puts 'Your guess:'
  end

  def display_error(word_length)
  	puts "Please type in a single letter or a #{word_length} letter word."
  end

  def display_letter_exist_error
  	puts 'You\'ve already used this letter'
  end

  def display_end_game(outcome, word)
  	if outcome == 'won'
  	  puts "You guessed it, #{word}!"
  	else
  	  puts "You might be more muggle than you thought! The word was '#{word}'"
  	  sleep(0.5)
  	  puts 'Just kidding, being good at word guessing doesn\'t mean you\'d make a bad witch/wizard'
  	end
  	puts ''
  end

  def display_replay_message(outcome)
  	puts "Since you #{outcome}, do you want to play again?"
  	puts "Type in 'yes' or 'no'"
  end

end
