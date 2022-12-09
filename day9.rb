#!/usr/bin/env ruby
require 'io/console'

steps = File.readlines(File.join(__dir__, 'day9-input.txt')).flat_map { |line|
  direction, steps = line.strip.split(' ', 2)
  Array.new(steps.to_i, direction.to_sym)
}

Position = Struct.new(:indicator, :x, :y) do
  def initialize(indicator, x = 0, y = 0)
    super(indicator, x, y)
  end

  def dup
    self.class.new(indicator, x, y)
  end
end

def dump(width, height, head, tail)
  same = head.x == tail.x && head.y == tail.y

  (0...height).to_a.reverse.each do |y|
    (0...width).each do |x|
      if head.x == x && head.y == y && same
        print('!')
      elsif head.x == x && head.y == y
        print(head.indicator)
      elsif tail.x == x && tail.y == y
        print(tail.indicator)
      else
        print('.')
      end
    end

    print("\n")
  end
end

head = Position.new('H')
tail = Position.new('T')

def distance(pos1, pos2)
  Math.sqrt(((pos1.x - pos2.x) ** 2) + ((pos1.y - pos2.y) ** 2)).truncate
end

tail_visited = []

steps.each do |step|
  x_change = 0
  y_change = 0

  case step
  when :R
    x_change = 1
  when :L
    x_change = -1
  when :U
    y_change = 1
  when :D
    y_change = -1
  end

  head.x += x_change
  head.y += y_change

  if distance(head, tail) > 1
    tail.x += x_change
    tail.y += y_change

    tail.y = head.y if x_change != 0 && tail.y != head.y
    tail.x = head.x if y_change != 0 && tail.x != head.x
  end

  tail_visited << tail.dup

  if distance(head, tail) > 1
    raise 'Something didn\'t move right'
  end
end

part1 = tail_visited.uniq.length
puts part1