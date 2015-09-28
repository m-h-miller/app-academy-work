# We're going to implement a cipher called the Folding Cipher. Why? Because it
# folds the alphabet in half and uses the adjacent letter.
#
# For example,
# a <=> z
# b <=> y
# c <=> x
# ...
# m <=> n
#
# Hint: Thi

def folding_cipher(str)
  ciphered = str.split("")
  array = ciphered.map {|x| folding_cipher_letter(x) }
  array.join("")
end

def folding_cipher_letter(x)

  if x == "a"
    "z"
  elsif x == "b"
    "y"
  elsif x == "c"
    "x"
  elsif x == "d"
    "w"
  elsif x == "e"
  "v"
  elsif x == "f"
  "u"
  elsif x == "g"
  "t"
  elsif x == "h"
  "s"
  elsif x == "i"
  "r"
  elsif x == "j"
  "q"
  elsif x == "k"
  "p"
  elsif x == "l"
  "o"
  elsif x == "m"
  "n"
  elsif x == "n"
  "m"
  elsif x == "o"
  "l"
  elsif x == "p"
  "k"
  elsif x == "q"
  "j"
  elsif x =="r"
  "i"
  elsif x == "s"
  "h"
  elsif x == "t"
  "g"
  elsif x == "u"
  "f"
  elsif x == "v"
  "e"
  elsif x == "w"
  "d"
  elsif x == "x"
  "c"
  elsif x == "y"
  "b"
  elsif x == "z"
    "a"
  end
end


# Write a method that returns the factors of a number
def factors(num)
  arr=[]
  i = 1
  while i < (num)
    arr << i if num % i == 0
    i+=1
  end
  arr << num
  arr
end

# Jumble sort will take a string and return a string with the letters ordered
# according to the order of an alphabet array that will be handed to the method.
# If no alphabet array is provided, it should default to alphabetical order.

def jumble_sort(str, alphabet = nil)
  alphabet ||= ("a".."z").to_a
  str.split("").sort_by do |ltr|
    alphabet.index(ltr)
  end.join
end

class Array
  # Write an array method that returns `true` if the array has duplicated
  # values and `false` if it does not
  def dups
    self.uniq != self
  end
end

# Determine if a string is symmetrical. 'racecar' and
# 'too hot to hoot' are examples of symmetrical strings.
# You are NOT permitted to use Array#reverse,
# Array#reverse!, String#reverse, or String#reverse!
class String
  def symmetrical?(str)
    letters = str.split("")
    i=0
    while i < letters.size
      return false if letters[i] != letters[str.size - i]
      i+=1
    end
    return true
  end
end
