#!/usr/bin/env ruby

chunks = File.readlines(File.join(__dir__, 'DAY1DATA')).map(&:strip).chunk do |line|
  if line.strip.empty?
    :_separator
  else
    true
  end
end

tallied = chunks.map { |*, arr| arr.map(&:to_i).sum }
part1 = tallied.max

puts part1

part2 = tallied.sort.last(3).sum

puts part2