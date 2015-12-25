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

for lplaces=4,6 do
	for lcolors=math.max(6,lplaces),10 do
		for lusecolorsonce=0,1 do
			usecolorsonce=lusecolorsonce==0
			places=lplaces
			colors=lcolors
			minimum=1000000
			maximum=-1
			sum=0
			count=0
			start=os.time()
			while os.time()-start<30 or count<100 do
				hiddennumber=math.random(0,colors^places-1)
				hiddencomb={}
				for i=0,places-1 do
					hiddencomb[i]=math.mod(math.floor(hiddennumber/colors^i),colors)
				end
				while usecolorsonce and (function () colorsincomb={} for i=0,places-1 do colorsincomb[hiddencomb[i]]=(colorsincomb[hiddencomb[i]] or 0) + 1 end for i,v in pairs(colorsincomb) do if v>1 then return true end end return false end)() do
					hiddennumber=math.random(0,colors^places-1)
					hiddencomb={}
					for i=0,places-1 do
						hiddencomb[i]=math.mod(math.floor(hiddennumber/colors^i),colors)
					end
				end
				curtry=0
				combs={}
				if usecolorsonce then
					totpossible=0
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
				history={}
				while true do
					collectgarbage("collect")
					io.flush()
					possibles={}
					last=0
					for poscombnumber=0,colors^places-1 do
						if combs[poscombnumber]==nil then
							table.insert(possibles,poscombnumber)
						end	
					end
					suggestedcombnumber=possibles[math.random(1,#possibles)]
					possibles=nil
					suggestedcomb={}
					for i=0,places-1 do
						suggestedcomb[i]=math.mod(math.floor(suggestedcombnumber/colors^i),colors)
					end
					curtry=curtry+1
					redpins,whitepins=comparecombs(suggestedcomb,tablecopy(hiddencomb))
					if redpins==places then break end
					totpossible=0
					last=0
					for examinedcombnumber=0,colors^places-1 do
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
					if totpossible==0 then
						print("You liar!!!")
						totmistakes=0
						correctcomb=hiddencomb
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
						io.read()
						break
					end
				end
				minimum=math.min(minimum,curtry)
				maximum=math.max(maximum,curtry)
				count=count+1
				sum=sum+curtry
			end
			print("colors: "..colors.."  places: "..places.."  once: "..(usecolorsonce and "y" or "n").."  min: "..minimum.."  max: "..maximum.."  avg: "..sum/count)
		end
		print()
	end
end