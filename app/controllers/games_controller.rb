require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10).join
  end

  def valid(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = URI.open(url).read
    JSON.parse(user_serialized)
  end

  def include(letters, word)
  # all letters of word are in letters
    word.split("").each do |letter|
      # if letter not included in letters return false
      if !letters.include?(letter)
        return false
      end
    end
    true
  end

  def score
    valid = valid(params[:word])
    @word = params[:word].upcase
    @letters = params[:letters]
    @message = if include(params[:letters], params[:word])
                if valid[:found] == true
                  "Congratulations! #{@word} is a valid Engilsh word!"
                else
                  "Sorry but #{@word} does not seem to be a valid Engilsh word"
                end
              else
                "Sorry but #{@word} can't be build out of #{@letters}"
              end
  end
end
