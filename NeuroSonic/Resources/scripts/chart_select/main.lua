
-- requires `generic-layer.lua`

function Override.AsyncLoad()
	local bgLandscape, bgPortrait = LoadGenericBackgrounds();

	Layouts.Landscape.BackgroundTexture = bgLandscape;
	Layouts.WideLandscape.BackgroundTexture = bgLandscape;
	
	Layouts.Portrait.BackgroundTexture = bgPortrait;
	Layouts.TallPortrait.BackgroundTexture = bgPortrait;

	return true;
end

-- Landscape Layout

function Layouts.Landscape.Update(self, delta, total)
end

function Layouts.Landscape.Draw(self)
	DrawBackgroundFilled(self.BackgroundTexture);
end

-- Wide Landscape Layout

function Layouts.WideLandscape.Update(self, delta, total)
end

function Layouts.WideLandscape.Draw(self)
	DrawBackgroundFilled(self.BackgroundTexture);
end

-- Portrait Layout

function Layouts.Portrait.Update(self, delta, total)
end

function Layouts.Portrait.Draw(self)
	DrawBackgroundFilled(self.BackgroundTexture);
end

-- Tall Portrait Layout

function Layouts.TallPortrait.Update(self, delta, total)
end

function Layouts.TallPortrait.Draw(self)
	DrawBackgroundFilled(self.BackgroundTexture);
end

