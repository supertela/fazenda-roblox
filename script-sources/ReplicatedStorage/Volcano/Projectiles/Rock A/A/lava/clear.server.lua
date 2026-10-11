m=script.Parent
while true do
wait(.01)
if m.Anchored==false then
wait(4)
m.Transparency=.3
wait(3)
m.Transparency=.6
wait(2)
m.Transparency=.9
wait(1)
m:Remove()
end
end
