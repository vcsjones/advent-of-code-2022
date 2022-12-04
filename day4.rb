#!/usr/bin/env ruby

def parse_pair(line)
  line.split(',', 2).map { |pair|
    start, stop = pair.split('-', 2).map(&:to_i)
    start..stop
  }
end

pairs = File.readlines(File.join(__dir__, 'day4-input.txt')).map(&:strip).map(&method(:parse_pair))

part1 = pairs.filter { |pair1, pair2|
    pair1.cover?(pair2) || pair2.cover?(pair1)
}.length

puts part1

part2 = pairs.filter { |pair1, pair2|
  ((pair1.to_a) & (pair2.to_a)).any?
}.length

puts part2