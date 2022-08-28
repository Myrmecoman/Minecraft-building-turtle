function move(wanted_x, wanted_y, wanted_z)

	-- going up first
	if not (turtle_y == wanted_y) then
		-- +y movement
		if turtle_y < wanted_y then
			while turtle_y < wanted_y do
				turtle_y = turtle_y + 1
				b = turtle.up()
				if not b then
					hibernate()
					turtle.up()
				end
			end
		end
	end

	if not (turtle_x == wanted_x) then

		-- +x movement
		if turtle_x < wanted_x then
			while not(y_rot == 0) do
				turtle.turnLeft()
				y_rot = (y_rot + 1) % 4
			end
			while turtle_x < wanted_x do
				turtle_x = turtle_x + 1
				b = turtle.forward()
				if not b then
					hibernate()
					turtle.forward()
				end
			end
		end

		-- -x movement
		if turtle_x > wanted_x then
			while not(y_rot == 2) do
				turtle.turnLeft()
				y_rot = (y_rot + 1) % 4
			end
			while turtle_x > wanted_x do
				turtle_x = turtle_x - 1
				b = turtle.forward()
				if not b then
					hibernate()
					turtle.forward()
				end
			end
		end

	end

	if not (turtle_z == wanted_z) then

		-- +z movement
		if turtle_z < wanted_z then
			while not(y_rot == 1) do
				turtle.turnLeft()
				y_rot = (y_rot + 1) % 4
			end
			while turtle_z < wanted_z do
				turtle_z = turtle_z + 1
				b = turtle.forward()
				if not b then
					hibernate()
					turtle.forward()
				end
			end
		end

		-- -z movement
		if turtle_z > wanted_z then
			while not(y_rot == 3) do
				turtle.turnLeft()
				y_rot = (y_rot + 1) % 4
			end
			while turtle_z > wanted_z do
				turtle_z = turtle_z - 1
				b = turtle.forward()
				if not b then
					hibernate()
					turtle.forward()
				end
			end
		end

	end

	-- going down last
	if not (turtle_y == wanted_y) then
		-- -y movement
		if turtle_y > wanted_y then
			while turtle_y > wanted_y do
				turtle_y = turtle_y - 1
				b = turtle.down()
				if not b then
					hibernate()
					turtle.down()
				end
			end
		end
	end
	
end


-- get and build a slice of the construction
function analyse()
	tryRefuel()
	yfound = false
	-- proccess all blocks with the y coordinates
	for k,v in pairs(darray) do
		if v[2] == y then
			yfound = true
			print("Moving to ", v[1], ",", v[2], ",", v[3])
			move(v[1], v[2] + 1, v[3])
			placeBlockDown()
		end
	end
 
	if yfound == false then
		print("Job is finished, exiting")
		return false
	end

	y = y + 1
	turtle_y = turtle_y + 1
	turtle.up()

	return true
end


function placeBlockDown()
	bool = turtle.placeDown()
	if not bool then
		select_id = (select_id % 16) + 1
		turtle.select(select_id)
		bool2 = turtle.placeDown()
		if not bool2 then
			print("No more materials, refilling")
			hibernate()
			turtle.placeDown()
		end
	end
end


function hibernate()
	while turtle.getFuelLevel() < 5 do
		tryRefuel()
		sleep(1)
		return
	end

	old_x = turtle_x
	old_y = turtle_y
	old_z = turtle_z

	move(-1, 1, 0)
	while turtle.suckDown() do
		-- sucking
	end
	move(old_x, old_y, old_z)
end


function to_vector(s)
    local t = {}
    s:gsub('%-?%d+', function(n) t[#t+1] = tonumber(n) end)
    return t
end


-- see if the file exists
function file_exists(file)
	local f = io.open(file, "rb")
	if f then f:close() end
	return f ~= nil
end


-- get all lines from a file
function lines_from(file)
	if not file_exists(file) then return {} end
	lines = {}
	for line in io.lines(file) do 
	  lines[#lines + 1] = line
	end
	return lines
end


function tryRefuel()	
	for i = 1, 16 do
		turtle.select(i)
		if turtle.refuel(0) then -- if it's valid fuel
			turtle.refuel(turtle.getItemCount(i)) -- consume all
		end
	end
	turtle.select(select_id)
end


--[[ MAIN EXECUTION ]]
-- start the turtle on the ground and give it enough space for building
select_id = 1
select(select_id)
tryRefuel()
y_rot = 0
turtle_x = -1
turtle_y = 1
turtle_z = 0
y = 0

local all_lines = lines_from('model_sorted.txt')

darray = {}
for k,v in pairs(all_lines) do
	darray[k] = to_vector(v)
end

while analyse() do
	-- looping
end
