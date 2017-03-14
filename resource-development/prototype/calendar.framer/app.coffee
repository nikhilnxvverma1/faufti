
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
	height: 281

upperFade.style.background = "-webkit-linear-gradient(90deg, rgba(1,71,128,0.00) 0%, #014880 100%)"

lowerFade = new Layer
	width: 767
	height: 281
	y: 892

lowerFade.style.background = "-webkit-linear-gradient(top, rgba(1,71,128,0.00) 0%, #014880 100%)"

calendar=new ScrollComponent
	width: 750
	height: 1173
	scrollHorizontal:false
	scrollVertical:true
	
calendar.contentInset=
	left: 100

calendar.placeBefore(background)
calendar.content.backgroundColor="#004079"

dayCellSize=60
gutter=20
xGap=10
yGap=10
dayOfWeek=0
weekNo=0
dayNoFontSize="18pt"
for dayNumber in [0...365]
	dayOfMonth=dayNoInMonth(dayNumber)+1
	day = new Layer
		parent: calendar.content
		borderRadius: 100
		width: dayCellSize
		height: dayCellSize
		html:dayOfMonth
		style:"text-align":"center"
		x:dayOfWeek*(dayCellSize+xGap)
		y:weekNo*(dayCellSize+gutter)
		borderWidth: 3
		borderColor: "rgba(254,253,255,0.5)"
		backgroundColor: "rgba(123,123,123,0)"
		
	day.style["padding-top"]=dayCellSize/4 + "px"
	day.style["font-size"]=dayNoFontSize

	if dayOfWeek++ == 7
		dayOfWeek=0
		weekNo++
		





