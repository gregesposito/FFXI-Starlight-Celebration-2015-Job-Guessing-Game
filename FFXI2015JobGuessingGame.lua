math.randomseed(os.time())
for i=1,100 do math.random() end

print("Super Fuck This Mind v2 by Tritonio")
print("Copyright 2008,2009 Konstantinos Asimakis")
print("http://inshame.blogspot.com")
print("Do whatever you want as long as you keep that copyright.")
print()

function tablecopy(t)
	local new={}
	for i,v in pairs(t) do
		new[i]=t[i]
	end
	return new
end

function round(n,d)
	return math.floor(n*10^d+0.5)/10^d
end

function combnumbertotable(combnumber)
	local combtable={}
	for i=0,places-1 do
		combtable[i]=math.mod(math.floor(combnumber/colors^i),colors)
	end
	return combtable
end

function comparecombs(trycomb,correctcomb) --Destructive for correctcomb!!! (use tablecopy inline to avoid)
	local redpins=0
	local whitepins=0
	local used={}
	for a=0,places-1 do
		if trycomb[a]==correctcomb[a] then redpins=redpins+1 correctcomb[a]=-1 used[a]=1 end
	end
	for a=0,places-1 do
		if used[a]==nil then
			for b=0,places-1 do
				if trycomb[a]==correctcomb[b] then whitepins=whitepins+1 correctcomb[b]=-1 break end
			end
		end
	end
	return redpins,whitepins
end

h=io.open("colors.txt")
if h then
	colors=h:read()
	h:close()
else	
	io.write("Advanced? (Y/n) ")
    if (io.read()=="n") == true then
        colors=6
    else
        colors=9
    end
end


	places=5

	usecolorsonce=false

	play=true

colornames={}
h=io.open("colornames.txt")
if h then
	for i=0,colors-1 do
		colornames[i]=h:read()
	end	
	h:close()
else
	for i=0,colors-1 do
		colornames[i]=i
	end
end
reverse={}
for number,colorname in pairs(colornames) do
	reverse[colorname]=number
end

print()

curtry=0
combs={}
if usecolorsonce then
	totpossible=0
	print("Excluding combinations that contain the same job twice...")
	for examinedcombnumber=0,colors^places-1 do
		colorsincomb={}
		for i=0,places-1 do
			colorsincomb[math.mod(math.floor(examinedcombnumber/colors^i),colors)]=(colorsincomb[math.mod(math.floor(examinedcombnumber/colors^i),colors)] or 0) + 1
		end
		for i,v in pairs(colorsincomb) do
			if v>1 then
				combs[examinedcombnumber]=true
				break
			end
		end
		if combs[examinedcombnumber]==nil then totpossible=totpossible+1 end
	end
else
	totpossible=colors^places	
end

print("There are "..totpossible.." possible combinations.")
print("Current try's success probability: "..round(100/totpossible,2).."%")

history={}

while true do
	collectgarbage("collect")
	io.write("Deciding")
	io.flush()
	possibles={}
	last=0
	for poscombnumber=0,colors^places-1 do
		if math.floor(10*poscombnumber/(colors^places-1))>=last then last=last+1 io.write(".") io.flush() end
		if combs[poscombnumber]==nil then
			table.insert(possibles,poscombnumber)
		end	
	end
	print()
	suggestedcombnumber=possibles[math.random(1,#possibles)]
	possibles=nil
	suggestedcomb={}
	for i=0,places-1 do
		suggestedcomb[i]=math.mod(math.floor(suggestedcombnumber/colors^i),colors)
	end
	curtry=curtry+1
	io.write("Try #"..curtry..": ")
	for i=places-1,0,-1 do
		io.write(colornames[suggestedcomb[i]].." ")
	end
	if not play then io.write("(suggested)") end
	print()
	if totpossible==1 then print("This must be the correct combination!!!") end
	if not play then
		print("What is your move? Leave empty to use the suggestion.")
		move=io.read()
		if move~="" then
			moveindex=places-1
			for word in string.gmatch(move,"%w+") do
				suggestedcomb[moveindex]=reverse[word]
				moveindex=moveindex-1
			end
		end
	end	
	io.write("How many CH:? ")
	redpins=tonumber(io.read()) or 0
	if redpins==places then print("Found it!!!") break end
	io.write("How many H:? ")
	whitepins=tonumber(io.read()) or 0
	totpossible=0
	io.write("Thinking")
	last=0
	for examinedcombnumber=0,colors^places-1 do
		if math.floor(10*examinedcombnumber/(colors^places-1))>=last then last=last+1 io.write(".") io.flush() end
		if combs[examinedcombnumber]==nil then
			examinedcomb={}
			for i=0,places-1 do
				examinedcomb[i]=math.mod(math.floor(examinedcombnumber/colors^i),colors)
			end
			examinedredpins,examinedwhitepins=comparecombs(suggestedcomb,examinedcomb)
			if (whitepins~=examinedwhitepins or redpins~=examinedredpins) then combs[examinedcombnumber]=true end
		end
		if combs[examinedcombnumber]==nil then totpossible=totpossible+1 end
	end
	table.insert(history,{comb=tablecopy(suggestedcomb),redpins=redpins,whitepins=whitepins})
	print()
	print()
	print("There are "..totpossible.." possible combinations.")
	if totpossible>1 then print("Current try's success probability: "..round(100/totpossible,2).."%") end
	if totpossible==0 then
		print("Tell me what was the correct combination and I will find your mistakes:")
		correct=io.read()
		correctcomb={}
		for word in string.gmatch(correct,"%w+") do
			correctindex=places-1
			for word in string.gmatch(correct,"%w+") do
				correctcomb[correctindex]=reverse[word]
				correctindex=correctindex-1
			end
		end
		totmistakes=0
		for oldtrynumber,oldtry in ipairs(history) do
			correctredpins,correctwhitepins=comparecombs(oldtry.comb,tablecopy(correctcomb))
			if correctredpins~=oldtry.redpins or correctwhitepins~=oldtry.whitepins then
				totmistakes=totmistakes+1
				io.write("In try #"..oldtrynumber..": ")
				for i=places-1,0,-1 do
					io.write(colornames[oldtry.comb[i]].." ")
				end
				print("you gave "..oldtry.redpins.."-"..oldtry.whitepins.." but the correct was "..correctredpins.."-"..correctwhitepins..".")
			end
		end
		print(round(totmistakes/#history*100,0).."% of your answers were wrong.")
		break
	end
end
