require './game.rb'
require './random_player.rb'
require './your_player.rb'
require './helper.rb'

srand(129)

grid_size = 5

your_strategy = -> {
  game = Game.new(grid_size: grid_size)

  player = YourPlayer.new(game: game, name: 'Main Player')
  player2 = YourPlayer.new(game: game, name: 'Main Player 2')
  player3 = YourPlayer.new(game: game, name: 'Main Player 3')

  game.add_player(player)
  game.add_player(player2)
  game.add_player(player3)

  game.start
}

random_strategy = -> {
  game = Game.new(grid_size: grid_size)

  random_player = RandomPlayer.new(game: game, name: 'Rando 1')
  random_player2 = RandomPlayer.new(game: game, name: 'Rando 2')
  random_player3 = RandomPlayer.new(game: game, name: 'Rando 3')

  game.add_player(random_player)
  game.add_player(random_player2)
  game.add_player(random_player3)

  game.start
}

random_results = random_strategy.call
your_results = your_strategy.call

compare_hashes(your_results, random_results)
