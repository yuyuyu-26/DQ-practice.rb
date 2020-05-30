require "./character"
class Monster < Character
    POWER_UP_RATE = 1.5
    CALC_HALF_HP = 0.5

    def initialize(**params)
        super(
            name: params[:name],
            hp: params[:hp],
            offense: params[:offense],
            defense: params[:defense]
        )
        @transform_flag = false
        @trigger_of_transform = params[:hp] * CALC_HALF_HP
    end

    def attack(brave)
        if @hp <= @trigger_of_transform && @transform_flag == false
            @transform_flag = true
            transform
        end
        attack_type = critical_attack
        damage = calculate_damage(target: brave, attack_type: attack_type)
        cause_damage(target: brave, damage: damage)
        puts "----------------------------------"
        attack_message(attack_type: attack_type)
        damage_message(target: brave, damage: damage)
    end

    private

        def critical_attack #変身前後のダメージの設定
            if @transform_flag == true
                "fatal_strike"
            else
                "normal_strike"
            end
        end

        def calculate_damage(**params) #変身前後のダメージ判定
            target = params[:target]
            attack_type = params[:attack_type]
            if attack_type == "fatal_strike"
                @offense - target.defense
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

        def transform #変身
            transform_name = "ゾーマ（覚醒）"
            transform_message(origin_name: @name, transform_name: transform_name)
            @offense *= POWER_UP_RATE
            @name = transform_name
        end

end