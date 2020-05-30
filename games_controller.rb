require './message_dialog'
class GamesController
    include MessageDialog
    EXP_CONSTANT = 2
    GOLD_CONSTANT = 3

    def battle(**params)
        build_characters(params)
        puts "------------------------"
        puts "#{@monster.name}があらわれた！"

        loop do
            #勇者1人目のターン
            puts <<~TEXT
            ------------------------
            #{@brave.name}
            ＨＰ：#{@brave.hp.floor}
            ＭＰ：#{@brave.mp.floor}

            #{@brave1.name}
            ＨＰ：#{@brave1.hp.floor}
            ＭＰ：#{@brave1.mp.floor}
            ------------------------
            #{@brave.name}の行動を選択
            １．こうげき
            ２．とくぎ
            ３．ベホイミ(消費MP:15)
            ４．にげる
            TEXT
            @select = gets.chomp.to_i

            if @select == 1
              @brave.attack(@monster)
              break if battle_end?
            elsif @select == 2
              puts <<~TEXT
              #{@brave.name}の行動を選択
              １．ギガスラッシュ(消費MP:30)
              ２．ミラクルソード(消費MP:20)
              TEXT
              @skill = gets.chomp.to_i
              if @skill == 1
                @brave.skill(@monster)
                break if battle_end?
              elsif @skill == 2
                @brave.skill2(@monster)
                break if battle_end?
              else
                puts <<~TEXT
                1か2を選択してください
                TEXT
              end
            elsif @select == 3
              @brave.heal(@brave)
            elsif @select == 4
              break
            else
              puts <<~TEXT
              1か2か3を選択してください
              TEXT
            end

            #勇者二人目のターン
            puts <<~TEXT
            ------------------------
            #{@brave.name}
            ＨＰ：#{@brave.hp.floor}
            ＭＰ：#{@brave.mp.floor}

            #{@brave1.name}
            ＨＰ：#{@brave1.hp.floor}
            ＭＰ：#{@brave1.mp.floor}
            ------------------------
            #{@brave1.name}の行動を選択
            １．こうげき
            ２．とくぎ
            ３．ベホイミ(消費MP:15)
            ４．にげる
            TEXT
            @select2 = gets.chomp.to_i

            if @select2 == 1
              @brave1.attack(@monster)
              break if battle_end?
            elsif @select2 == 2
              puts <<~TEXT
              #{@brave1.name}の行動を選択
              １．アルテマソード(消費MP:50)
              ２．ルカ二(消費MP:30)
              TEXT
              @skill = gets.chomp.to_i
              if @skill == 1
                @brave1.skill3(@monster)
                break if battle_end?
              elsif @skill == 2
                @brave1.skill4(@monster)
                break if battle_end?
              else
                puts <<~TEXT
                1か2を選択してください
                TEXT
              end
            elsif @select2 == 3
              @brave1.heal(@brave1)
            elsif @select2 == 4
              break
            else
              puts <<~TEXT
              1か2か3を選択してください
              TEXT
            end

            #モンスターのターン
            @monster.attack(@brave)
            break if battle_end?
            @monster.attack(@brave1)
            break if battle_end?
            
        end
        #勝敗判定
        battle_judgment
    end

        private

          def build_characters(**params) #キャラクターのパラメーター受け取り
            @brave = params[:brave]
            @brave1 = params[:brave1]
            @monster = params[:monster]
          end

          def battle_end? #どちらかのHPが0以下になれば終了
            @brave.hp <= 0 && @brave1.hp <= 0 || @monster.hp <= 0
          end

          def brave_win? #勇者たちの勝利条件
            @monster.hp <= 0
          end

          def battle_judgment #勝敗判定+メッセージ
            result = calculate_of_exp_and_gold
            end_message(result)
          end

          def calculate_of_exp_and_gold #勝敗判定により経験値とゴールド取得
            if brave_win?
                brave_win_flag = true
                exp = (@monster.offense + @monster.defense) * EXP_CONSTANT
                gold = (@monster.offense + @monster.defense) * GOLD_CONSTANT
            else
                brave_win_flag = false
                exp = 0
                gold = 0
            end
            {brave_win_flag: brave_win_flag, exp: exp.floor, gold: gold.floor}
          end
end