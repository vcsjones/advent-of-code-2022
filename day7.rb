#!/usr/bin/env ruby

Node = Struct.new(:name, :children, :parent, :size) do
  def root
    node = self

    while !node.parent.nil?
      node = node.parent
    end

    node
  end

  def total_size
    total = 0

    self.visit do |child|
      total += child.size unless child.size.nil?
    end

    total
  end

  def find_child(name)
    self.children.find { |c| c.name == name }
  end

  def visit(&block)
    yield self

    unless self.children.nil?
      children.each do |child|
        child.visit(&block)
      end
    end
  end

end

lines = File.readlines(File.join(__dir__, 'day7-input.txt')).map(&:strip)
root = Node.new('/', [], nil, nil)

def process_output(state, outputs, lsing = false)
  output, *tail = outputs

  return if output.nil?

  if output.start_with?('$ ')
    _, command, *args = output.split(' ')

    case command
    when 'cd'
      dir = args.join(' ')

      case dir
      when '/'
          process_output(state.root, tail)
      when '..'
        process_output(state.parent, tail)
      else
        existing_child = state.find_child(dir)
        process_output(existing_child, tail)
      end
    when 'ls'
      process_output(state, tail, true)
    else
      raise "Unknown command '#{command}'"
    end
  elsif lsing
    if output.start_with?('dir')
      _, name = output.split(' ', 2)
      state.children << Node.new(name, [], state, nil)
      process_output(state, tail, lsing)
    else
      size, name = output.split(' ', 2)
      state.children << Node.new(name, nil, state, size.to_i)
      process_output(state, tail, lsing)
    end
  else
    raise 'invalid state.'
  end
end

process_output(root, lines)

part1 = 0

root.visit do |child|
  part1 += child.total_size if child.size.nil? && child.total_size <= 100000
end

puts part1

total_space = 70_000_000
needed_space = 30_000_000
used_space = root.total_size

part2 = nil

root.visit do |child|
  next unless child.size.nil?

  if used_space - child.total_size + needed_space <= total_space
    if part2.nil? || child.total_size < part2.total_size
      part2 = child
    end
  end
end

puts "#{part2.name} #{part2.total_size}"
