# These methods are all used to print things to the screen
module Display
  def display_instructions
  	puts ''
  	puts 'Welcome to Hangman: The Hogwarts Editions'
  	puts ''
  	puts 'Like the regular hangman, you\'ll be given a word represented by blank spaces.
  		You will have 6 guesses to figure out the word. 
  		You can guess a single letter or you can attempt to guess the entire word. 
  		If guessing the entire word, you won\'t get feedback on which letters are and aren\'t present.'
  	puts ''
  	puts 'Press ENTER to start the game'
  	gets
  end

  def display_blanks(word)
  	puts "A #{word.length} letter word."
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
  	 puts 'You only have 4 guesses left'
  	  when 4
  	 puts '3 more turns'
  	when 3
  	 puts '2 guesses remaining'
  	when 2
  	 puts '1 turns left yo'
  	end
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
  end

  def display_get_guess
  	puts 'Your guess:'
  end

  def display_error(word_length)
  	puts "Please type in a single letter or a #{word_length} letter word."
  end

  def display_end_game(outcome, word)
  	if outcome == 'won'
  	  puts "You guessed it, #{word}!"
  	else
  	  puts "You might be more muggle than you thought! The word was '#{word}.'"
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
