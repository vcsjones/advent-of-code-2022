#!/usr/bin/env -S bundle exec ruby

def objectify(play)
  case play
  when "A", "X"
    :rock
  when "B", "Y"
    :paper
  when "C", "Z"
    :scissors
  else
    raise "Unknown play #{play}"
  end
end


def resultify(play)
  case play
  when "X"
    :lose
  when "Y"
    :draw
  when "Z"
    :win
  else
    raise "Unknown play #{play}"
  end
end

def score_play(opponent, me)
  lookup = {
    rock: {
      rock: 1 + 3,
      paper: 1 + 0,
      scissors: 1 + 6
    },
    paper: {
      rock: 2 + 6,
      paper: 2 + 3,
      scissors: 2 + 0,
    },
    scissors: {
      rock: 3 + 0,
      paper: 3 + 6,
      scissors: 3 + 3,
    }
  }

  lookup[me][opponent]
end


def score_result(opponent, me)
  lookup = {
    lose: {
      rock: 3,
      paper: 1,
      scissors: 2,
    },
    draw: {
      rock: 1 + 3,
      paper: 2 + 3,
      scissors: 3 + 3,
    },
    win: {
      rock: 2 + 6,
      paper: 3 + 6,
      scissors: 1 + 6,
    }
  }

  lookup[me][opponent]
end


def score_match(match)
  opponent, me = match.split(' ').map(&method(:objectify))
  score_play(opponent, me)
end

def score_results(match)
  a, b = match.split(' ')
  opponent = objectify(a)
  me = resultify(b)

  score_result(opponent, me)
end

lines = File.readlines(File.join( __dir__,'day2-input.txt'))
part1 = lines.map(&method(:score_match)).sum
puts part1


part2 = lines.map(&method(:score_results)).sum
puts part2

