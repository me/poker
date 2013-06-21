require './hand'

TEST_CASES = [
  ['2H 3D 5S 9C KD', '2C 3H 4S 8C AH', -1],
  ['2H 4S 4C 2D 4H', '2S 8S AS QS 3S', 1],
  ['2H 5S 4C 2D 4H', '2S 8S AS QS 3S', -1],
  ['2H 3D 5S 9C KD', '2C 3H 4S 8C KH', 1],
  ['2H 3D 5S 9C KD', '2D 3H 5C 9S KH', 0],
  ['2H 2D 5S 9C KD', '2C 3H 4S 8C AH', 1],
  ['2H 2D 5S 9C KD', '2C 2H 4S 8C AH', -1],
  ['2H 2D 5S 9C KD', '3H 3D 5S 9C KD', -1],
  ['2H 2D 3S 3C KD', '2C 2H 4S 8C AH', 1],
  ['2H 2D 4S 4C KD', '2C 2H 3S 3C AH', 1],
  ['2H 2D 2S 4C KD', 'KC KH 3S 3C AH', 1],
  ['2H 2D 2S 2C KD', 'KC KH 3S 3C 3H', 1],
  ['2H 3H 4H 5H 6H', '2H 2D 2S 2C KD', 1],
  ['2H 3H 4H 5H 6H', '3H 4H 5H 6H 7H', -1],
]

TEST_CASES.each do |c|
  h1 = Poker::Hand.new(c[0].split(' '))
  h2 = Poker::Hand.new(c[1].split(' '))
  if (h1 <=> h2) == c[2] 
    print "."
  else
    print "F"
  end
end
puts ""