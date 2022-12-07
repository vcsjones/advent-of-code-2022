#!/usr/bin/env ruby

input = File.read(File.join(__dir__, 'day6-input.txt')).strip

def window(input, window_size)
  Enumerator.new do |acc|
    step = input
    offset = window_size
    while step.length >= window_size do
      acc << [offset, step[0...window_size]]
      offset += 1
      step = step[1..]
    end
  end
end

part1 = window(input, 4).find { |index, packet|
  packet.chars.uniq.length == packet.length
}

puts part1[0]

part2 = window(input, 14).find { |index, packet|
  packet.chars.uniq.length == packet.length
}

puts part2[0]