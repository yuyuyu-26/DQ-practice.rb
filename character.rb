require "./message_dialog"
class Character
    include MessageDialog

    attr_accessor :name, :hp, :mp, :offense, :defense

    def initialize(**params)
        @name = params[:name]
        @hp = params[:hp]
        @mp = params[:mp]
        @offense = params[:offense]
        @defense = params[:defense]
    end
    
end