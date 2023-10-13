local min = math.min

function love.run()
    if love.math then love.math.setRandomSeed(os.time()) end

	if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end

	local dt = 1 / 60

	-- Main loop time.
	return function()
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end

        local frameTime
		-- Update dt, as we'll be passing it to update
		if love.timer then frameTime = love.timer.step() end

        -- Might run into the so called "Spiral of Death"
        while frameTime > 0 do
            local delta = min(frameTime or dt, dt)
            -- Call update at a fixed maximum rate
            if love.update then love.update(delta) end
            frameTime = frameTime - delta
        end

        -- Call draw when update has finished
		if love.graphics and love.graphics.isActive() then
			love.graphics.origin()
			love.graphics.clear(love.graphics.getBackgroundColor())

			if love.draw then love.draw() end

			love.graphics.present()
		end

		if love.timer then love.timer.sleep(0.001) end
	end
end