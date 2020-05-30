require './brave'
require './monster'
require './games_controller'

games_controller = GamesController.new

roto = Brave.new(name: "ロト", hp: 2000, mp: 120, offense: 600, defense: 300) #勇者クラスをインスタンス化
arusu = Brave.new(name: "アルス", hp: 1800, mp: 150, offense: 600, defense: 300)
zoma = Monster.new(name: "ゾーマ", hp: 9000, offense: 350, defense: 200) #モンスタークラスをインスタンス化

games_controller.battle(brave: roto, brave1: arusu, monster: zoma)




