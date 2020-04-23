class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word 
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end


  def guess(guess) 

    raise ArgumentError if !guess || guess.empty? || !guess.match(/[A-Za-z]/)
    
    guess.downcase!

    return false if @guesses.index(guess) || @wrong_guesses.index(guess)
    
    if word.index(guess)
      @guesses << guess
    else
      @wrong_guesses << guess
    end 
  end

  def word_with_guesses
    str = ''
    @word.each_char do |guess|
      if @guesses.index(guess)
        str << guess
      else
        str << '-'
      end
    end
    str
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if !word_with_guesses.index('-')  
    :play
  end
  
  

end

