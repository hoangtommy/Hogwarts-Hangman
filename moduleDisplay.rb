# These methods are all used to print things to the screen
module Display
  def display_instructions
  	puts ''
  	puts 'Welcome to Hangman: The Hogwarts Editions'
  	puts ''
  	puts 'Like the regular hangman, you\'ll be given a word represented by blank spaces.
  		You will have 6 guesses to figure out the word, 
  		at anytime you can attempt to guess the entire word. 
  		Doing so only counts as a single guess.'
  	puts ''
  	puts 'Press ENTER to start the game'
  	gets
  end

  def display_hangman(turns_left)
  	case(turns_left)
  	when 6
  	 'You have 6 turns left'
  	when 5
  	 'You only have 5 guesses left'
  	  when 4
  	 '4 more turns'
  	when 3
  	 '3 guesses remaining'
  	when 2
  	 '2 turns left yo'
  	else
  	 '1 guess left. make it good!'
  	end
  end

  def display_word(word, correct_letters) # assume word & correctLetters are arrays
  	word_length = word.length
  	puts ''
  	puts "#{word_length} letter word"

  	# word = [m, a, g, i, c]
  	# __ __ __ __ __
  	# correctLetters = [a, c]
    # __ a __ __ c
    word_display = ''

    word.each_with_index do |letter, idx|

      if correctLetters.include?(letter)
      	word_display
      	# "#{letter}" in word[idx] position
      else
      	# '__' in word[idx] position
      end
    end

  	puts "#{'__ ' * word_length}"
  	puts "#{correctLetters[0]}  #{correctLetters[0]}  #{correctLetters[0]}"
 
  end
end
