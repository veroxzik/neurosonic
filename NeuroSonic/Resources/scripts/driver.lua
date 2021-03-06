
local titleLoop;

function theori.layer.doAsyncLoad()
    theori.graphics.queueStaticTextureLoad("title");
    theori.graphics.queueStaticTextureLoad("audfx-text-large");

    titleLoop = theori.audio.queueStaticAudioLoad("launchtower-title-loop");

    return theori.doStaticLoadsAsync();
end

function theori.layer.doAsyncFinalize()
    return theori.finalizeStaticLoads();
end

-- on first startup, push the splash screen
function theori.layer.init()
	-- ensure that even if there are 0 charts in the collection, the
	--  Favorites collection always exists.
	theori.charts.createCollection("Favorites");

    local titleLoopBeatDuration = 60.0 / 132;
    
    titleLoop.volume = 0.3;
    titleLoop.setLoopArea(titleLoopBeatDuration * 4, titleLoopBeatDuration * 68);

    theori.charts.setDatabaseToClean(function()
        theori.charts.setDatabaseToPopulate(function() print("Populate (from driver) finished."); end);
    end);

    theori.layer.push("splashScreen");
end

-- any time someone gets back down to the driver, push a new splash screen
function theori.layer.resumed()
    theori.graphics.openCurtain();
    theori.layer.push("splashScreen");
end
