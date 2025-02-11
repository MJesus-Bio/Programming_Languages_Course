# coding: iso-8859-1
# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece

  All_My_Pieces = All_Pieces +
                  [rotations([[0, 0], [1, 0], [0, 1], [1, 1], [2, 1]]), # OK
                   [[[0, 0], [-2, 0], [-1, 0], [1, 0], [2, 0]], # long (5)
                    [[0, 0], [0, -2], [0, -1], [0, 1], [0, 2]]],
                   rotations([[0, 0], [0, 1], [1, 1]])] # 3 

  ## Update with MyPiece
  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  ## Cheat Piece
  def self.cheat_piece (board)
    MyPiece.new([[[0,0]]], board)
  end

end

class MyBoard < Board

  ## Initializes with MyPiece
  def initialize (game)
    super(game)
    @current_block = MyPiece.next_piece(self)
    @cheater = nil
  end

  ## Updates next_piece with MyPiece and with Cheat
  def next_piece
    super()
    @current_block = MyPiece.next_piece(self)
    if @cheater
      @current_block = @cheater
      @cheater = nil
    end
  end
    
  ## Rotates by 180 degrees
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end

  ## Change indexation to admit pieces with more/less blocks
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    size = locations.size - 1
    (0..size).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
        @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  ## Cheating
  def cheat
    if score >= 100 && !@cheater
      @cheater = MyPiece.cheat_piece(self)
      @score -= 100
    end
  end

end

class MyTetris < Tetris

  ## set board with MyBoard
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  ## add 'u' and 'c' key binding
  def key_bindings
    super()
    @root.bind('u', proc {@board.rotate_180})
    @root.bind('c', proc {@board.cheat})
  end

end


