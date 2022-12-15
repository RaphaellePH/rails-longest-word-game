class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @letters
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    answer_serialized = URI.open(url).read
    answer = JSON.parse(answer_serialized)

    if answer["found"] == true
      if @word.chars.all? do |letter|
        @word.count(letter) <= @letters.count(letter)
        end
        return @score = "Congratulations! #{@word} is a valid English word!"
      else
      return @score = "Sorry but #{@word} can't be built out of #{@letters}"
      end
    else
      return @score = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
