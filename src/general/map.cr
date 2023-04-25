# https://www.redblobgames.com/maps/terrain-from-noise/

module RenWorld
    class Map
        getter width : Int32
        getter height : Int32

        getter frequency : Float64

        property map : Array(Array(Float64))
        property elevation : Array(Array(Float64))

        property biom : Array(Array(RenWorld::BiomEnum))

        def initialize(@width, @height, @frequency = 2.0)
            noise = Noise2DContext.new

            @map = Array.new(height) { Array.new(width, 0.0) }
            @elevation = Array.new(height) { Array.new(width, 0.0) }
            
            @biom = Array.new(height) { Array.new(width, BiomEnum::Water) }

            height.times do |y|
                width.times do |x|
                    nx = x/width - 0.5
                    ny = y/height - 0.5

                    @map[y][x] = noise.get(nx, ny)

                    e = 1 * noise.get(1 * nx, 1 * ny)
                        +  0.5 * noise.get(2 * nx, 2 * ny)
                        + 0.25 * noise.get(4 * nx, 4 * ny)
                    e = e / (1 + 0.5 + 0.25)

                    @elevation[y][x] = e**0.5
                    @biom[y][x] = (RenWorld::Biom.new @elevation[y][x]).type
                end
            end
        end
    end
end