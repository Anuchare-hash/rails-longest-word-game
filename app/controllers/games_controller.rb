require 'open-uri'
require 'json'

class GamesController < ApplicationController
  LETTERS = Array.new(10){('A'..'Z').to_a.sample}
  def new
    @letters = LETTERS
  end

  def score
    @my_word = params[:word] #access params values using strings or symbols

    @my_word.chars.each do |word|
      if !LETTERS.include?(word)
        return @result = "Word cannot be built"
      end
    end

    @res = valid?(@my_word)
    if @res == true
      @result = "Congratulations! #{@my_word} is a valid English word"
    else
      @result = "Sorry but #{@my_Word} does not seem to be a valid English word"
    end
  end

  def valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_word = URI.open(url).read
    hash = JSON.parse(user_word)   #access the hash values using string and not symbol
    if hash["found"]
      return true
    end
  end
end
