#!/usr/bin/env ruby

def parse_stack_line(str)
  str.chars.each_slice(4).map { |s|
    crate = s.join('').strip
    crate.empty? ? nil : crate
  }
end

lines = File.readlines(File.join(__dir__, 'day5-input.txt')).map { |l| l.gsub(/[\r\n]/, '') }
config = lines.take_while { |l| !l.empty? }.to_a
*initial_stack, counts = config
stack_columns = counts.split(' ').map.with_index { |x, i| [x.to_i, i] }
stacks = Hash.new() { [] }

initial_stack.each do |line|
  stack = parse_stack_line(line)
  stack_columns.each do |column, index|
    next if stack[index].nil?
    stacks[column] = [stack[index]] + stacks[column]
  end
end

def deep_dup(stack)
  stack.map { |k, v| [k, v.dup ]}.to_h
end

def answerify(stack)
  stack.keys.sort.map { |k| stack[k].last }.join.delete('[').delete(']')
end

instructions = lines.drop_while { |l| !l.empty? }.drop(1)

def process(stack, instructions, preserve)
  stack = deep_dup(stack)
  instructions.each do |instruction|
    parsed = instruction.match(/\Amove (?<count>\d+) from (?<from>\d+) to (?<to>\d+)\z/).named_captures.map { |k, v| [k, v.to_i] }.to_h
    count, from, to = parsed["count"], parsed["from"], parsed["to"]

    if (preserve)
      items = stack[from].pop(count)
      stack[to] = stack[to] + items
    else
      items = stack[from].pop(count).reverse
      stack[to] = stack[to] + items
    end
  end

  answerify(stack)
end


puts process(stacks, instructions, false)
puts process(stacks, instructions, true)
