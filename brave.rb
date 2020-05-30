require "./character"
class Brave < Character
    SPECIAL_ATTACK_CONSTANT = 2
#通常攻撃
    def attack(monster)
        attack_type = critical_attack
        damage = calculate_damage(target: monster, attack_type: attack_type)
        cause_damage(target: monster, damage: damage)
        puts "----------------------------------"
        attack_message(attack_type: attack_type)
        puts "#{monster.name}に#{damage.floor}ダメージ！"
    end
#とくぎ一覧
    def skill(monster) #ギガスラッシュ
        if @mp >= 30
            damage = @offense * 3 - monster.defense
            monster.hp -= damage
            @mp -= 30
            puts <<~TEXT
             ----------------------------------
             #{@name}はギガスラッシュをはなった！
             #{monster.name}に#{damage.floor}のダメージ！
            TEXT
        else
            shortage_mp_message
        end
    end

    def skill2(monster) #ミラクルソード
        if @mp >= 20
            damage = @offense * 1.5 - monster.defense
            monster.hp -= damage
            @mp -= 20
            @hp += damage
            puts <<~TEXT
             ----------------------------------
             #{@name}はミラクルソードをはなった！
             #{monster.name}に#{damage.floor}のダメージ！
             ----------------------------------
             #{@name}の体力が#{damage.floor}回復！
            TEXT
        else
            shortage_mp_message
        end
    end

    def skill3(monster) #アルテマソード
        if @mp >= 50
            damage = @offense * 4 - monster.defense
            monster.hp -= damage
            @mp -= 50
            puts <<~TEXT
             ----------------------------------
             #{@name}はアルテマソードをはなった！
             #{monster.name}に#{damage.floor}のダメージ！
            TEXT
        else
            shortage_mp_message
        end
    end

    def skill4(monster) #ルカ二
        if @mp >= 30
            defense_down = monster.defense * 0.8
            monster.defense -= defense_down
            @mp -= 30
            puts <<~TEXT
             ----------------------------------
             #{@name}はルカ二をとなえた！
             #{monster.name}のしゅびりょくがさがった！
            TEXT
        else
            shortage_mp_message
        end
    end

    def heal(brave) #ベホイミ
        if @mp >= 20
            brave.hp += 800
            @mp -= 15
            puts <<~TEXT
             ----------------------------------
             ベホイミをとなえた！
             HPが300回復
            TEXT
        else
            shortage_mp_message
        end
    end

    private

        def critical_attack #会心の一撃の設定
            attack_num = rand(32)
            if attack_num == 0
                "critical_attack"
            else
                "normal_attack"
            end
        end

        def calculate_damage(**params) #会心の一撃の判定
            target = params[:target]
            attack_type = params[:attack_type]
            if attack_type == "critical_attack"
                calculate_special_attack - target.defense
            else
                @offense - target.defense
            end
        end

        def cause_damage(**params) #通常攻撃のダメージ計算
            damage = params[:damage]
            target = params[:target]
            target.hp -= damage
            target.hp = 0 if target.hp < 0
        end

        def calculate_special_attack #会心の一撃の倍率
            @offense * SPECIAL_ATTACK_CONSTANT
        end

end