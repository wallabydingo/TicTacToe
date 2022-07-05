# frozen_string_literal: true

class Player
  attr_accessor :name, :marker, :brain, :game

  @@all = []

  def initialize
    puts 'Name:'
    @name = gets.chomp
    puts 'Marker:'
    @marker = gets.chomp
    while @marker.length>1
      puts 'Single character, please.'
      @marker = gets.chomp
    end
    puts 'Computer or Human (c/h):'
    @brain = gets.chomp.downcase
    until @brain.eql?("c") || @brain.eql?("h")
      puts "Must choose c or h"
      @brain = gets.chomp.downcase
    end
    puts '══════════════════════════════════════'
    @@all << self
  end

  def name
    @name
  end

  def marker
    @marker
  end

  def choose_spot
    puts "","Where do you want to play it, #@name?"
    game.show_board
    if @brain == "c"
      spot = Random.new()
      spot = spot.rand(8) + 1
      spot = spot.to_s
    else
      spot = gets.chomp
    end
    if game.board.values.include?(spot)
      game.mark_board(@marker, spot.to_i)
    else
      puts 'Try again.'
      self.choose_spot
    end
  end
end

class Game
  attr_accessor :board

  @@board = {1=>'1', 2=>'2', 3=>'3', 4=>'4', 5=>'5', 6=>'6', 7=>'7', 8=>'8', 9=>'9'}
  
  
  def initialize
    @player = []
  end

  def add_player(player)
    @player << player
    player.game = self
  end

  def board
    @@board
  end

  def show_board
    board = @@board
    puts '','╭───┰───┰───╮'
    puts "│ #{board[1]} ┃ #{board[2]} ┃ #{board[3]} │", '┝━━━╋━━━╋━━━┥'
    puts "│ #{board[4]} ┃ #{board[5]} ┃ #{board[6]} │", '┝━━━╋━━━╋━━━┥'
    puts "│ #{board[7]} ┃ #{board[8]} ┃ #{board[9]} │", '╰───┸───┸───╯'
    puts ''
  end

  def mark_board(marker, position)
    board = @@board
    board[position] = marker
    @@board = board
  end

  def game_over?
    board = @@board
    (board[1] === board[2] && board[2] === board[3]) || (board[4] === board[5] && board[5] === board[6]) ||
      (board[7] === board[8] && board[8] === board[9]) || (board[1] === board[4] && board[4] === board[7]) ||
      (board[2] === board[5] && board[5] === board[8]) || (board[3] === board[6] && board[6] === board[9]) ||
      (board[1] === board[5] && board[5] === board[9]) || (board[3] === board[5] && board[5] === board[7])
  end
  
end

def play_game
  game = Game.new()

  
  
  puts '', 'Enter details, Player 1:'
  player1 = Player.new()
  game.add_player(player1)
  puts '', 'Enter details, Player 2:'
  player2 = Player.new()
  game.add_player(player2)

  while 
    player1.choose_spot
    if game.game_over?
      puts "","Congratulations, #{player1.name}! YOU WIN!"
      game.show_board
      break
    end
    puts '══════════════════════════════════════'
    player2.choose_spot
    if game.game_over?
      puts "","Congratulations, #{player2.name}! YOU WIN!"
      game.show_board
      break
    end
    puts '══════════════════════════════════════'
  end

  puts 'Play again? (y/n)'
  gets.chomp == "y" ? (load 'tic_tac_toe.rb') : (puts '','Goodbye!','')
  
  
end

play_game
