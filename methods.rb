def rps(string)
  choices = {
    'rock' => 'scissors',
    'paper' => 'rock',
    'scissors' => 'paper'
  }
  string = string.to_s.downcase
  
  return "Invalid selection" unless validator(string, choices)
  
  computer_choice = choices.keys.sample
  return "You won!" if choices[string] == computer_choice
  return "You tie!" if string == computer_choice
  "You lose."
end

def validator(string, hash)
  hash.has_key?(string)
end


#---
def remix(array)
  mixers = []
  array.each do |pair|
    mixers.push(pair[1])
  end
  mixers = mixers.shuffle
  array.count.times do |i|
    array[i][1] = mixers[i]
  end    
  array
end

#bonus problem: guarantee different mixer(SKIPPED)



