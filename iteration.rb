
def find_number(num = 1)
  while true
    return num if (num > 250) && (num % 7 == 0)
    num += 1
  end
end

def factors(num)
  factor = 1
  answer = []
  while factor < (num / 2) + 1
    answer << factor if (num % factor == 0)
    factor += 1
  end
  answer
end

def bubble_sort(array)
  sorted = false
  
  until sorted
    sorted = true
    (array.count - 1).times do |i|
      if array[i] > array[i + 1]
        #special parallel assignment!
        array[i], array[i + 1] = array[i + 1], array[i]
        sorted = false
      end
    end
  end
  array
end

def substrings(string)
  substrings = []
  str_len = string.length
  
  str_len.times do |start|
    str_len.times do |finish|
      break if (start + finish) >= str_len
      substrings << string[start..start + finish]
    end
  end
  substrings
end

def subwords(string)
  subwords = []
  substrings = substrings(string)
  dictionary = File.read("dictionary.txt").split
  
  substrings.each do |sub|
    subwords << sub if dictionary.include?(sub)
  end
  subwords
end

def subwords2(string)
  subwords = []
  substrings_array = substrings(string)
  contents = File.read("dictionary.txt").split
  
  substrings_array.each do |word|
    contents.each do |dict_word|
      if word == dict_word
        subwords << word
      end
    end
  end
  subwords
end