class Student
  
  
  def initialize(first, last)
    @first = first
    @last = last
    @courses = []
  end
  
  def name
    "#{@first} #{@last}"
  end
  
  def courses
    @courses
  end
  
  def enroll(course)
    unless @courses.include?(course)
      @courses << course 
      course.add_student(self)
    end
  end
  
  def to_s
    @name
  end
  
end

class Course
  def initialize(name, department, credits)
    @name = name
    @department = department
    @credits = credits
    @students = []
  end
  
  def students
    @students
  end
  
  def add_student(student)
    unless @students.include?(student)
      @students << student
      student.enroll(self)
    end
  end
  
  def to_s
    @name
  end
end
#EXTRAs to be done...

class Board
  attr_accessor :board
  
  def initialize(size = 3)
    @board = Array.new(size){ Array.new(size) }
  end
  
  def won(mark)
    not_mark = "X"
    not_mark = "O" unless mark == "O"
    @board.each do |row|
      return mark unless check_array(row, mark, not_mark)
    end
    
    #winner for columns
    @board.count.times do |row|
      column = []
      @board.count.times do |col|
        column << @board[col][row]
      end
      return mark unless check_array(column, mark, not_mark)
    end
    
    #diagonals
    check_diagonals(mark, not_mark)
  end
    
  def check_diagonals(mark, not_mark)
    diagonal1 = @board.count.times.collect{|i| @board[i][i]}
    return mark unless check_array(diagonal1, mark, not_mark)
    diagonal2 = @board.count.times.collect{|i| @board[i][@board.count - i - 1]}
    return mark unless check_array(diagonal2, mark, not_mark)
    false
  end
    
  def check_array(array, mark, not_mark)
    array.any? {|el| el == nil || el == not_mark}
  end
  
  def winner
    
  end
  
  def empty_pos?(pos)
    !@board[pos[0].to_i][pos[1].to_i]
  end
  
  def place_mark(pos, mark)
    @board[pos[0].to_i][pos[1].to_i] = mark if empty_pos?(pos)
  end
  
end

class Game
  def initialize
    @board = Board.new
    @size = @board.board.length
    @user = Player.new("Person")
    @computer = Player.new("Computer")
  end
  
  def play
    puts "Let's play"
    
    win = false
    until win
      display_board
      user_move = get_move
      @board.place_mark(user_move, 'X')
      win = @board.won('X')
      break if win
      computer_move = get_move(1)
      @board.place_mark(computer_move, "O")
      win = @board.won('O')
    end
    return "You won!" if win == "X"
    "You lost."
  end
  
  def get_move(computer = false)
    if computer
      return generate_move
    else
      puts "Player, enter your move 'row column'"
      player_move = gets.chomp.split
    end
    player_move
  end
  
  def generate_move
    #check if there is winning move
    #move = check_winning_move
    #return move if move
    #move either false or return coordinates of winning move
    while true
      move = (0..@size - 1).to_a.sample(2)
      return move if @board.board[move[0]][move[1]] == nil
    end
  end
  
  def check_winning_move
    @size.times do |i|
      @size.times do |j|
        @board.place_mark([i, j], 'O') if @board.board[i][j] == nil
        if @board.won('O')
          @board.board[i][j] = nil
          return [i, j]
        else
          @board.board[i][j] = nil
        end
      end
    end
    display_board
    false  
  end
  
  def display_board
    @board.board.each do |row|
      p row
    end
  end
end


class Player
  def initialize(name)
    @name = name
  end   
end

class HumanPlayer < Player
end

class ComputerPlayer < Player
end


