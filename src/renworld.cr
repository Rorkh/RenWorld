require "./lib/noise.cr"

require "./general/biom.cr"
require "./general/map.cr"

require "sdl"

map = RenWorld::Map.new 256 * 2, 256 * 2

SDL.init(SDL::Init::VIDEO)
at_exit { SDL.quit }

window = SDL::Window.new("RenWorld", 256 * 2, 256 * 2)
renderer = SDL::Renderer.new(window)

loop do
  event = SDL::Event.wait

  case event
  when SDL::Event::Quit
    break
  when SDL::Event::Keyboard
    if event.mod.lctrl? && event.sym.q?
      break
    end
  end

  renderer.draw_color = SDL::Color[255, 255, 255, 255]
  renderer.clear

  map.height.times do |y|
    map.width.times do |x|
      biom = map.biom[y][x]

      if biom == RenWorld::BiomEnum::Water
        renderer.draw_color = SDL::Color[0, 255, 0, 255]
      elsif biom == RenWorld::BiomEnum::Beach
        renderer.draw_color = SDL::Color[194, 178, 128]
      elsif biom == RenWorld::BiomEnum::Forest
        renderer.draw_color = SDL::Color[124, 252, 0]
      elsif biom == RenWorld::BiomEnum::Jungle
        renderer.draw_color = SDL::Color[41, 171, 135]
      elsif biom == RenWorld::BiomEnum::Savannah
        renderer.draw_color = SDL::Color[209, 163, 110]
      elsif biom == RenWorld::BiomEnum::Desert
        renderer.draw_color = SDL::Color[168, 143, 89]
      elsif biom == RenWorld::BiomEnum::Snow
        renderer.draw_color = SDL::Color[255, 250, 250]
      else
        renderer.draw_color = SDL::Color[255, 0, 0, 255]
      end

      renderer.fill_rect(x, y, 1, 1)
    end
  end  

  renderer.present
end