module RenWorld
    enum BiomEnum
        Water
        Beach
        Forest
        Jungle
        Savannah
        Desert
        Snow
    end

    class Biom
        getter elevation : Float64
        getter type : BiomEnum

        def initialize(@elevation)
            if (elevation < 0.1) 
                @type = BiomEnum::Water
            elsif (elevation < 0.2) 
                @type = BiomEnum::Beach
            elsif (elevation < 0.3) 
                @type = BiomEnum::Forest
            elsif (elevation < 0.5) 
                @type = BiomEnum::Jungle
            elsif (elevation < 0.7) 
                @type = BiomEnum::Savannah
            elsif (elevation < 0.9) 
                @type = BiomEnum::Desert
            else 
                @type = BiomEnum::Snow
            end
        end
    end
end