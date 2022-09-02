local window = 0
local a = 0
-- local viewsections = {2,3,8,10,18,19,28,29,38,39,40,41,50,52,53,54,55,60,61,62,63,68,69,70,71,72,73,74,75,76,78,80,82,108,109,110,111,118,119,122,123,134,138,-1}
local start_Rock_Num = 2
local end_Rock_Num = 12
local tracer = 1
local rock_Stuff = {
	0
}
local trigger = false
local preSection = -5
local CUR_SECTION = 0
local windowGoal = 24
local hd = 0

function start (song)
	print("Song: " .. song .. " @ " .. bpm .. " downscroll: " .. downscroll)
	
	window = 24

    

	for i=start_Rock_Num, end_Rock_Num do
		local actor_Name = "undefinedSprite" .. tostring(i)

		table.insert(rock_Stuff, getActorY(actor_Name))
	end

    if difficulty == 'SIMPLE' then
        hd = 0
    else if difficulty == 'EASY' then
        hd = 1
    else
        hd = 2
    end
    end
end

function update(elapsed)
	CUR_SECTION = math.floor((songPos/1000) * (bpm/60)/4)
    -- (viewsections[tracer] == CUR_SECTION) or
	if trigger then
		setActorPos(getActorX("dadCharacter1")+600, getActorY("dadCharacter1") + 850, "dad")
		lock = true
    --    shitty event code
        -- if not (CUR_SECTION == preSection) then
        --     trigger = false
        --     print('current preSection: ' .. preSection.. ' current CUR_SECTION: ' .. CUR_SECTION)
        -- end
	else
		setActorPos(getActorX("dadCharacter0"), getActorY("dadCharacter0") + 650, "dad")
		if lock == true then
			tracer = tracer + 1
		end
		lock = false
	end
    if curBeat == 228 then
        setActorAlpha(1, "dadCharacter0")
    end
    if curBeat == 235 then
        setActorAlpha(1, "dadCharacter1")
    end
    if math.floor((songPos/1000) * (bpm/60)) == 256 then
        windowGoal = 240
    end
	a = a + (elapsed * 1.5)
	setActorPos(-400 + ((math.cos(a) * 2) * window), -2450 + (math.sin(2 * a) * window), "dadCharacter0")
	setActorPos(-1400 + ((math.cos(-a) * 2) * window), -2450 + (math.sin(2 * -a) * window), "dadCharacter1")

	for i=start_Rock_Num, end_Rock_Num do
		local actor_Name = "undefinedSprite" .. tostring(i)
		
		setActorPos(getActorX(actor_Name), rock_Stuff[i] + (math.sin(2 * (a + i)) * 80), actor_Name)
	end

    window = window + ((windowGoal - window)*(elapsed/(0.004*crochet)))

	setActorPos(getActorX('bfCharacter1') - 300, getActorY('bfCharacter1') + 200, "bf_rock")
	setActorPos(getActorX('girlfriend') - 10, getActorY('girlfriend') + 575, "gf_rock")
end

print("Mod Chart script loaded :)")

function onEvent(a,b,c,d)
    if a == 'switch view' then
        if trigger then
            trigger = false
        else
            trigger = true
        end
    end
    if a == "Change Character" then
        setActorAlpha(0, "dadCharacter0")
        setActorAlpha(0, "dadCharacter1")
    end
end


-- old event code
-- function onEvent(a,b,c,d)
--     if a == 'switch view' then
--         CUR_SECTION = math.floor((b/1000) * (bpm/60)/4)
--         if (not trigger) or not (CUR_SECTION == preSection) then
--             preSection = math.floor((b/1000) * (bpm/60)/4)
--             print(preSection)
--             trigger = true
--         else
--             trigger = false

--         end
--     end
        
-- end


function playerTwoSing(data, time, type) 
    if getHealth()-(hd/54)> 0 then
        setHealth(getHealth()-(hd/54))
        print(getHealth())
        
    else
        setHealth(0.01)
    end
end