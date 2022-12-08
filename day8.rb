#!/usr/bin/env ruby

Grid = Class.new do
  def initialize(input)
    @original = input.map { |line| line.chars.map(&:to_i) }
    @transposed = @original.transpose
  end

  def row(y)
    @original[y]
  end

  def column(x)
    @transposed[x]
  end

  def at(x, y)
    @transposed[x][y]
  end

  def visible?(x, y)
    return true if x == 0 || y == 0 || x + 1 == width || y + 1 == height

    value = at(x, y)
    row, column = row(y), column(x)

    before_row = row[0...x]
    after_row = row[x + 1..]
    before_column = column[0...y]
    after_column = column[y + 1..]

    [before_row, after_row, before_column, after_column].any? { |section|
      section.all? { |r| r < value }
    }
  end

  def view(iter, limit)
    score = 0

    iter.each do |c|
      score += 1
      break if c >= limit
    end

    return score
  end

  def score(x, y)

    value = at(x, y)
    row, column = row(y), column(x)

    before_row_score = view(row[0...x].reverse, value)
    after_row_score = view(row[x + 1..], value)
    before_column_score = view(column[0...y].reverse, value)
    after_column_score = view(column[y + 1..], value)

    before_row_score * after_row_score * before_column_score * after_column_score
  end

  def width
    @original.length
  end

  def height
    @transposed.length
  end
end

lines = File.readlines(File.join(__dir__, 'day8-input.txt')).map(&:strip).to_a
grid = Grid.new(lines)

part1 = 0
part2 = 0
(0...grid.width).each do |x|
  (0...grid.height).each do |y|
    v = grid.visible?(x, y)
    part1 += 1 if v

    score = grid.score(x, y)
    part2 = score if score > part2
  end
end

puts part1
puts part2
