local ColorSchemeGenerator = {}

local function hslToRgb(h, s, l)
	local function hueToRgb(p, q, t)
		if t < 0 then t += 1 end
		if t > 1 then t -= 1 end
		if t < 1/6 then return p + (q - p) * 6 * t end
		if t < 1/2 then return q end
		if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
		return p
	end

	local r, g, b

	if s == 0 then
		r, g, b = l, l, l
	else
		local q = l < 0.5 and l * (1 + s) or l + s - l * s
		local p = 2 * l - q
		r = hueToRgb(p, q, h + 1/3)
		g = hueToRgb(p, q, h)
		b = hueToRgb(p, q, h - 1/3)
	end

	return Color3.new(r, g, b)
end

function ColorSchemeGenerator.Generate(schemeType, count)
	local colors = {}
	local baseHue = math.random()
	local sat = 0.6
	local light = 0.5

	for i = 1, count do
		local hue
		if schemeType == "complementary" then
			hue = (baseHue + ((i % 2 == 0) and 0.5 or 0)) % 1
		elseif schemeType == "analogous" then
			hue = (baseHue + (i - 1) * 0.08) % 1
		elseif schemeType == "triadic" then
			hue = (baseHue + ((i - 1) * 1/3)) % 1
		else
			hue = math.random() -- fallback to random
		end
		table.insert(colors, hslToRgb(hue, sat, light))
	end

	return colors
end

return ColorSchemeGenerator
