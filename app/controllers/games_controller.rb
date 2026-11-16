require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    letters = params[:letters]
    word = params[:word]

    @msg ="-1"
    @word = word
    @letters = letters

    if included?(word, letters)
      if english_word?(word)
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

  def included?(word, grid)
    word.upcase.chars.all? do |letter|
      grid.upcase.include?(letter)
    end
  end

end
