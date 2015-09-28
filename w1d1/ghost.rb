require 'set'
require 'byebug'

DICT = Set.new

File.open('ghost-dictionary.txt') do |f|
  f.each {|line| DICT << line.strip}
end


class Game
  attr_reader :players, :fragment, :dictionary, :losses

  def initialize(*players)
    @players = players
    @fragment = ""
    @dictionary = DICT
    @losses = {}
    players.each { |player| @losses[player] = "" }
  end

  def play_round
    while !round_over?
      take_turn(current_player)
      record_loss(current_player) if round_over?
      next_player!
    end
    display_loss
    reset_fragment!
  end

  def run
    while !game_over?
      play_round
      display_standings
      if player_eliminated?
        eliminate_player!
      end
    end
    display_winner
  end

  private

    def current_player
      players.first
    end

    def previous_player
      players[-1]
    end

    def next_player!
      players.rotate!
    end

    def take_turn(player)
      choice = ""
      until valid_play?(choice)
        puts fragment
        choice = player.guess(fragment, players.length - 1)
        player.alert_invalid_guess unless valid_play?(choice)
      end
      @fragment += choice
    end

    def valid_play?(str)
      return false unless str =~ /^\w$/
      dictionary.any? { |word| word.start_with?(fragment + str) }
    end

    def record_loss(player)
      @losses[player] = "GHOST".slice(0, losses[player].length + 1)
    end

    def round_over?
      dictionary.include?(fragment)
    end

    def reset_fragment!
      @fragment = ""
    end

    def display_loss
      puts "#{previous_player.name} loses the round: #{fragment}"
    end

    def player_eliminated?
      losses.values.map(&:length).max >= 5
    end

    def display_standings
      losses.each do |player, status|
        puts "#{player.name} : #{status}"
      end
    end

    def game_over?
      players.length == 1
    end

    def eliminate_player!
      @players.reject! { |player| losses[player].length >= 5 }
    end

    def display_winner
      puts players.first.name + " wins!!!" if game_over?
    end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess(*_) #garbage variable for duck-type
    puts "Enter a letter, #{name}: "
    gets.chomp
  end

  def alert_invalid_guess
    puts "Invalid guess"
  end
end

class AIPlayer
  attr_reader :name, :dictionary

  def initialize(name = "COMPUTER")
    @name = name
    @dictionary = DICT
  end

  def guess(fragment, n)
    choices = valid_choices(fragment)
    return choices.first if choices.length == 1

    possibilities = get_possiblities(choices)

    min_choice = get_min_choice(possibilities)

    return min_choice.first if winning_choice?(min_choice, fragment, n)

    choices.sample
  end

  def possible_words(start)
    dictionary.select { |word| word.start_with?(start) }
  end

  def valid_choices(fragment)
    choices = ("a".."z").to_a
    choices.reject! do |choice|
      dictionary.include?(fragment + choice) ||
      !dictionary.any? { |word| word.start_with?(fragment + choice) }
    end
  end

  def get_possibilities(choices)
    choices.reduce({}) do |poss, choice|
      poss.merge({choice => possible_words(fragment + choice)})
    end
  end

  def get_min_choice(possibilities)
    min_choice = possibilities.min_by do |choice, poss|
      poss.max_by { |val| val.length }.length
    end
    min_choice[1] = min_choice[1].max_by { |word| word.length }
  end

  def winning_choice?(min_choice, fragment, n)
    min_choice[-1].length - fragment.length - 1 <= n
  end

end

if __FILE__ == $PROGRAM_NAME
  ryan = Player.new("Ryan")
  harry = Player.new("Harry")
  cpu = AIPlayer.new
  game = Game.new(ryan, harry, cpu)
  game.run
end
