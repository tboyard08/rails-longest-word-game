require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    letters = params[:letters].gsub(",", "")
    word = params[:word]

    @score = 0
    @msg ="-1"
    @word = word
    @letters = letters

    if included?(word, letters)
      if english_word?(word)
        #score = compute_score(attempt, time)
        @msg = "1"
      else
        @msg = "0"
      end
    end
  end

  def english_word?(word)
    response = URI.parse("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?(guess, grid)
    grid_letters = grid.chars.tally
    guess_letters = guess.chars.tally

    guess_letters.all? do |letter, count|
      count <= grid_letters.fetch(letter, 0)
    end
  end

end
