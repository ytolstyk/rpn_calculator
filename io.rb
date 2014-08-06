#! usr/bin/env ruby

def guess
  computer = rand(1...100)
  counter = 0
  player = 0
  until computer == player
    puts "Pick a number between 1 and 100"
    player = gets.chomp
    break if player.downcase == "quit"
    begin
      player = Integer(player)
    rescue ArgumentError => e
      puts e
    end
    
    if valid(player)
      puts "Too low" if player < computer
      puts "Too High" if player > computer
      counter += 1
      puts "You have tried #{counter} times."
    end
  end
  
  puts "Game Over"
end

def valid(num)
  (1..100).include?(num)
end


#------- this is sexy!


def rpn_calculator
  
  unless ARGV.empty?
    stack = File.read(ARGV[0]).split
  else
    stack = make_stack
  end
  
  return "Exiting..." if stack.include?("quit")
  
  stack_of_numbers = []
  operations = %w(+ - * /)
  
  until stack.empty?
    symbol = stack.shift
    if operations.include?(symbol)
      stack_of_numbers = evaluate(stack_of_numbers, symbol)
    else
      stack_of_numbers << symbol
    end
  end
  stack_of_numbers.pop  
end

def evaluate(stack , symbol)
  stack << eval("#{stack.pop} #{symbol} #{stack.pop}".split.reverse.join(" "))
end

def make_stack
  stack = []
  while true
    puts "Input a number or an operation"
    symbol = gets.chomp
    
    if symbol.downcase == "quit"
      stack << symbol.downcase
      break 
    end
    
    break if symbol == ""
    if valid(symbol)
      stack << symbol
    end
  end
  stack
end

def valid(symbol)
  operations = %w(+ - * /)
  return true if operations.include?(symbol)
  begin
    symbol = Integer(symbol)
  rescue ArgumentError => error
    puts error
    return false
  end
  true
end

if __FILE__ == $PROGRAM_NAME
  puts rpn_calculator
end


def file_shuffler
  file_name = user_prompt
  return "Exiting..." if file_name.downcase == "quit"
  file = File.readlines(file_name).shuffle
  write_file = File.open("#{file_name}-shuffled.txt", "w")
  counter = 0
  file.each do |line|
    print "." if counter % 10 == 0
    print counter / 100 if counter % 100 == 0
    write_file.puts line
    counter += 1
  end
  write_file.close
  "All done!"
end

def user_prompt
  while true
    puts "Input a file name: "
    file_name = gets.chomp
    break if file_name.downcase == "quit"
    if valid_file(file_name)
      break
    end
  end
  file_name
end

def valid_file(file_name)
  File.exists?(file_name)
end

