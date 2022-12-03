#!/usr/bin/env -S bundle exec ruby

def score(letter)
  case letter
  when 'a'..'z'
    letter.ord - 'a'.ord + 1
  when 'A'..'Z'
    letter.ord - 'A'.ord + 1 + 26
  else
    raise "Unexpected letter #{letter}"
  end
end

lines = File.readlines(File.join(__dir__, 'day3-input.txt')).map(&:strip)

part1 = lines.map { |str|
  compartment1 = str[0, str.length / 2].chars
  compartment2 = str[str.length / 2..-1].chars
  common = compartment1 & compartment2
  score(common[0])
}.sum

puts part1

part2 = lines.each_slice(3).map { |group|
  common = group.map(&:chars).reduce(:&)
  score(common[0])
}.sum

puts part2