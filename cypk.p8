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
hack_time = 0
hack_dur = 20 -- ticks, abt 1 sec
gravity = 0.5
tgl = 0

pl = {}
pl.speed = 4
pl.maxspeed = 4
pl.yspeed = 0
pl.score = 0
pl.hscr = 0
pl.sprite = 1 -- current sprite
pl.bsprite = 1 -- begin cycle
pl.esprite = 4 -- end cycle
pl.x = 20 -- these will change
pl.y = 100 -- once i figure out where ground is
pl.width = 8
pl.height = 8
pl.jumping = true
pl.hacking = false
pl.data = 0
-- the player can jump 18 units high
-- so no platform should be more than 16 units higher than current

platforms = {}

-- custom functions

function solid(x,y,cell)
  cell = cell or false
  if x < 0 or x > 128 or y < 0 or y > 128 then
    return true
  end
  if cell then
    x = getcell(x)
    y = getcell(y)
  end
  tgt = mget(x,y)
  return fget(tgt,0)
end

function getcell(x)
  return flr(x/8)
end

function add_platform()
  
end

-- required functions

function _init()

end

function _update()
  if (playing == true) then
    if (music_playing == false) then
      music(0)
      music_playing = true
    end
    
    if pl.hacking == true then
      hack_time += 1
      if hack_time >= hack_dur then
        pl.hacking = false
        pl.data += 1
        pl.sprite = 1
        pl.speed = pl.maxspeed
        hack_time = 0
      end
    else
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
       if (solid(getcell(pl.x), getcell(pl.y)+1) == true) then
         pl.yspeed = 0
         pl.jumping = false
         pl.y = (flr(pl.y/8)*8)
       elseif (pl.y >= 127) then
         playing = false
         cursor(50,50)
         music(-1)
         print("game over")
       end
     end
     if btn(2) and pl.jumping == false then
       pl.speed = 0
       pl.hacking = true
       pl.sprite = 0
     end
   end
  end
end

function _draw()
  if (playing == true) then
    cls()
    map(0,0,0,0,32,32)
    road = 5
    if tgl == 3 then
      road = 11 - road
      tgl = 0
    end
    for x=0,17 do
      mset(x,15,road)
    end
    tgl += 1
    spr(pl.sprite, pl.x, pl.y)
    cursor(0,2)
    print("score: "..pl.score.."  data: "..pl.data)
    if true then
      cursor(0,10)
      print("x: "..pl.x.."  y: "..pl.y)
      cursor(0,20)
      print("is "..mget(getcell(pl.x), getcell(pl.y)+1).." solid? ")
      if solid(getcell(pl.x), getcell(pl.y)+1) == true then
        print("yes")
      else
        print("no")
      end
    end
  end
end

__gfx__
0002e000002e2e00002e2e00002e2e00002e2e00dddddddddddddddd000000000000000000000000000000000000000000000000000000000000000000000000
00fe2e0002e2ef0002e2ef0002e2ef0002e2ef00dddddddddddddddd000000000000000000000000000000000000000000000000000000000000000000000000
00f2e2e02e2ebb002e2ebb002e2ebb002e2ebb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00ff2e0000ffff0000ffff0000ffff0000ffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555550055555500555555005555550055555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0055550050555500505555005055550050555500a0000aaa0aaaa000000000000000000000000000000000000000000000000000000000000000000000000000
0050050000500500005005000050050000500500a0000aaa0aaaa000000000000000000000000000000000000000000000000000000000000000000000000000
00500500005005000500050005005000005000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
011000000c3550c3550c3550c355183550c3550c3550c3550c3550c3550c3550c355183550c3550c3550c355113551135511355113551d355113551135511355133551335513355133551f35513355113550e355
011000000c6550c6550c6550c65530655000000c6550c6550c6550c655306550c65530655306550c655306550c6550c6550c6550c65530655000000c6550c6550c6550c655306553065500000306553065500000
011000002370000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000000000000000000000000000000000000000000000000000000000
__music__
00 00414344
03 00014344

