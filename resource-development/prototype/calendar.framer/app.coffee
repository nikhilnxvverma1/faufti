
#-------------------------------- Helpers --------------------------------

monthList=["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"]

# totalMonthDays=[31,28,30,31,30,31,30,31,30,31,30,31]

totalDaysInMonth=(monthIndex,leapYear=false)->
	totalDays=31
	if monthIndex%2!=0 # even months are odd coz index starts from 0
		if monthIndex==1
			if leapYear
				totalDays=29
			else
				totalDays=28
		else
			totalDays=30
	return totalDays
	
dayNoInMonth = (dayOfYear,leapYear=false) ->
	month=monthOfYear(dayOfYear,leapYear)
	return dayOfYear-daysBeforeMonth(month,leapYear)
	
monthOfYear=(dayOfYear,leapYear=false)->
	daysPassed=0
	monthIndex=0
	while(monthIndex<12 && daysPassed<=dayOfYear)
		daysPassed+=totalDaysInMonth(monthIndex,leapYear)
		monthIndex++
	return monthIndex-1
	
daysBeforeMonth=(month,leapYear=false)->
	daysPassed=0
	monthIndex=0
	while(monthIndex<month)
		daysPassed+=totalDaysInMonth(monthIndex,leapYear)
		monthIndex++
	return daysPassed

verticalHtmlString=(str)->
	html=''
	for ch,i in str
		html+=ch
		if i<str.length-1
			html+='<br/>'
	return html

background=new BackgroundLayer
	width: 750
	height: 1334
	backgroundColor: "#004079"

workoutLog = new Layer
	y: 1173
	width: 750
	height: 161
	backgroundColor: "#F9F9F9"

workoutLabel = new Layer
	html: "Workout"
	height: 98
	width: 750
	color: "#EB35A9"
	y: 64
	backgroundColor: "rgba(135,135,135,0)"
	style:"text-align":"center","font-size":"40pt"

	
workoutLog.addChild(workoutLabel)

upperFade = new Layer
	width: 767
	height: 372

upperFade.style.background = "-webkit-linear-gradient(90deg, rgba(1,71,128,0.00) 0%, #014880 100%)"

lowerFade = new Layer
	width: 767
	height: 372
	y: 800
	x: -3

lowerFade.style.background = "-webkit-linear-gradient(top, rgba(1,71,128,0.00) 0%, #014880 100%)"

calendarHeight=1173
calendar=new ScrollComponent
	width: 750
	height: calendarHeight
	scrollHorizontal:false
	scrollVertical:true

calendar.placeBefore(background)
calendar.content.backgroundColor="#004079"

dayCellSize=70
weekXOffset=100
xGap=15
yGap=15
dayOfWeek=0
weekNo=0
dayNoFontSize="18pt"
monthXOffset=15
monthYOffset=30
monthGap=4*(yGap+dayCellSize)
lastMonth=-1
dayList=[]
for dayNumber in [0...365]
	
	monthNo=monthOfYear(dayNumber)
	if monthNo!=lastMonth
		lastMonth=monthNo
		month=new Layer
			parent: calendar.content
			width: 58
			height: 160
			x: monthXOffset
			y: monthYOffset+(weekNo+1)*(dayCellSize+yGap) # label is at the center
			borderColor: "rgba(254,253,255,0.5)"
			backgroundColor: "rgba(75,222,56,0)"
			style:"text-align":"center","font-size":"40pt"
			html:verticalHtmlString(monthList[monthNo])
		month.style['font-size']='20pt'

	dayOfMonth=dayNoInMonth(dayNumber)+1
	day = new Layer
		parent: calendar.content
		borderRadius: 100
		width: dayCellSize
		height: dayCellSize
		html:dayOfMonth
		style:"text-align":"center"
		x:weekXOffset+dayOfWeek*(dayCellSize+xGap)
		y:weekNo*(dayCellSize+yGap)
		borderWidth: 3
		borderColor: "rgba(254,253,255,0.5)"
		backgroundColor: "rgba(123,123,123,0)"
		
	day.style["padding-top"]=dayCellSize/4 + "px"
	day.style["font-size"]=dayNoFontSize
	dayList.push(day)
	
	# randomly set styles
	random=Math.random()
	if random>0.1
		day.backgroundColor="#029638"
		day.borderWidth=0
		day.color="#ffffff"
		if random>0.8
			day.backgroundColor="#ccc"
			day.color="#000"
		if random>0.99
			day.backgroundColor="RGBA(252, 199, 0, 1.00)"


	if dayOfWeek++ == 6
		dayOfWeek=0
		weekNo++

#------------------------------ Events -------------------------------

calendar.onScroll ->
	if calendar.scrollY<0
		return
	
	unitSize=dayCellSize+yGap
	spanningArea=5*unitSize
	
	extraScrolled=calendar.scrollY%unitSize
	weekOffset=Math.floor((extraScrolled/unitSize)*7)
	
	qualifyingY=calendar.scrollY+calendarHeight/2-spanningArea/2-extraScrolled
	
	startDay=0
	for i in [0...365]
		dayList[i].opacity=0.4
		if dayList[i].y>=qualifyingY
			startDay=i
			break
	for i in [startDay...startDay+weekOffset]
		dayList[i].opacity=0.4
		
	startDay+=weekOffset
	endDay=startDay+30
	for i in [endDay...365]
		dayList[i].opacity=0.4
		
	for i in [startDay...endDay]
		dayList[i].opacity=1
		
	
	