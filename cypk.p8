pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- cypk
-- possibly an infinite runner?
-- who knows
-- by noelle anthony
-- at mischievess studios

-- global variables

level = 0 -- ground (0) or roof (1)
playing = true
music_playing = false
dl_len = 1000 -- milliseconds
gravity = 0.5

pl = {}
pl.speed = 4
pl.yspeed = 0
pl.score = 0
pl.hscr = 0
pl.sprite = 1 -- current sprite
pl.bsprite = 1 -- begin cycle
pl.esprite = 4 -- end cycle
pl.x = 20 -- these will change
pl.y = 20 -- once i figure out where ground is
pl.width = 8
pl.height = 8
pl.jumping = true
pl.data = 0

-- required functions

function _init()

end

function _update()
  if (playing == true) then
    if (music_playing == false) then
      music(0)
      music_playing = true
    end
    
    pl.hscr += 1
    pl.score = flr(pl.hscr / 10)
    
      
    if (pl.jumping == true) then
      pl.sprite = 3
    else
      pl.sprite += 1
      if (pl.sprite > pl.esprite) then
        pl.sprite = pl.bsprite
      end
    end
    if (btn(5) and pl.jumping == false) then
      pl.jumping = true
      pl.yspeed = pl.speed
      pl.y -= pl.yspeed
    elseif (pl.jumping == true) then
      if (pl.yspeed >= (0 - pl.speed)) then
        pl.yspeed -= gravity
      end
      pl.y -= pl.yspeed
      if (pl.y >= 100) then
        pl.yspeed = 0
        pl.jumping = false
      end
    end
  end
end

function _draw()
  if (playing == true) then
    cls()
    spr(pl.sprite, pl.x, pl.y)
    cursor(0,2)
    print("score: "..pl.score.."  data: "..pl.data)
  end
end

__gfx__
00000000002e2e00002e2e00002e2e00002e2e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000002e2ef0002e2ef0002e2ef0002e2ef000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007002e2ebb002e2ebb002e2ebb002e2ebb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000ffff0000ffff0000ffff0000ffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000055555500555555005555550055555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700505555005055550050555500505555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000005005000050050000500500005005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000005005000500050005005000005000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
