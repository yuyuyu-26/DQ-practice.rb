module MessageDialog
    def attack_message(**params)
        attack_type = params[:attack_type]
        puts "#{@name}のこうげき！"
        puts "会心の一撃！" if attack_type == "critical_attack"
        puts "かえんぎり！" if attack_type == "normal_attack"
        puts "メラガイアーをとなえた！" if attack_type == "fatal_strike"
        puts "こごえるふぶきをはいた！" if attack_type == "normal_strike"
    end

    def shortage_mp_message
        puts <<~TEXT
        ----------------------------------
        MPが足りない！
        TEXT
    end

    def damage_message(**params)
        target = params[:target]
        damage = params[:damage]
        puts "#{target.name}は#{damage.floor}のダメージを受けた！"
    end

    def end_message(result)
        if result[:brave_win_flag]
            puts <<~TEXT
             ----------------------------------
             勇者は勝利した
             #{result[:exp]}の経験値と#{result[:gold]}のゴールドを手に入れた
             ----------------------------------
            TEXT
        else
            puts <<~TEXT
             ----------------------------------
             勇者は負けた
             目の前が真っ暗になった
             ----------------------------------
            TEXT
        end
    end

    def transform_message(**params)
        origin_name = params[:origin_name]
        transform_name = params[:transform_name]
        puts <<~TEXT
         #{origin_name}の魔力がみるみるうちに増大していく
         #{origin_name}は#{transform_name}に変身した
        TEXT
    end

end