class GameController < ApplicationController

  def game
    @length = params[:length] ? params[:length].to_i : 8
    @grid = generate_grid(@length)
    @start_time = Time.now
    session["start"] = @start_time
    session["grid"] = @grid
  end

  def score
    @grid = session["grid"]
    @start_time = Time.parse(session["start"])
    @attempt = params[:attempt]
    @end_time = Time.now
    @results = run_game(@attempt, @grid, @start_time, @end_time)

  end

  private

  def generate_grid(grid_size)
    alphabet = "a b c d e f g h i j k l m n o p q r s t u v w x y z"
    array_alphabet = alphabet.upcase.split
    grid = []
    grid_size.times do
      grid << array_alphabet.sample
    end
    return grid
  end

  def run_game(attempt, grid, start_time, end_time)
    array = []
    attempt.each_char { |x| array << x.upcase }
    y = array.all? { |letter| array.count(letter) <= grid.count(letter) }
    # y = array.sort <=> grid.sort[0...array.length]
    h = { time: end_time - start_time, translation: "", score: 0, message: "not in the grid" } if y == false
    h = { time: end_time - start_time, translation: "", score: attempt.length / (end_time - start_time), message: "well done" } if y == true
    return h
  end
end
