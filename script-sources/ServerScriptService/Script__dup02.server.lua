task.wait()
for i,v in pairs(game.Lighting:GetChildren()) do
	if v:IsA("ColorCorrectionEffect") then
		v.Brightness = 0
	end
end