function _init()
    game_over=false
    make_waves()
    make_player()
end

function _update()
    if (not game_over) then
        update_waves()
        move_player()
        check_hit()
    end
end

function _draw()
    cls()
    draw_waves()
    draw_player()
end

function make_player()
    player={}
    player.x=24 --position
    player.y=60
    player.dy=0 --fall speed
    player.rise=1 --sprites
    player.fall=2
    player.dead=3
    player.speed=2 --fly speed
    player.score=0
end

function draw_player()
    if (game_over) then
        spr(player.dead,player.x,player.y)
    elseif (player.dy<0) then
        spr(player.rise,player.x,player.y)
    else
        spr(player.fall,player.x,player.y)
    end
end

function move_player()
    gravity=0.2 
    player.dy+=gravity

    if (btnp(2)) then
        player.dy-=5
    end

    player.y+=player.dy
end

function make_waves()
    waves={{["height"]=20}}
    max_wave_height=40
end

function update_waves()
    --remove the back of the wave array
    if (#waves>player.speed) then
        for i=1,player.speed do
            del(waves, waves[1])
        end
    end
    --add more waves
    while (#waves<128) do
        local new_wave={}
        local height=flr(rnd(max_wave_height))+1
        new_wave["height"]=height
        add(waves,new_wave)
    end
end

function draw_waves()
    water_color=12
    crest_color=6
    for i=1,#waves do
        line(i-1, 128, i-1, 128-waves[i]["height"]+1, water_color)
        line(i-1, 128-waves[i]["height"]+1, i-1, 128-waves[i]["height"]+1, crest_color)
    end
end

function check_hit()
    for i=player.x, player.x+7 do
        if ( (128-waves[i]["height"]) < player.y + 7) then
            game_over=true
            return
        end
    end
end