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
	left: 300

calendar.placeBefore(background)
calendar.content.backgroundColor="#004079"

dayCellSize=100
gutter=20
for dayNumber in [1...31]
	day = new Layer
		parent: calendar.content
		borderRadius: 100
		width: dayCellSize
		height: dayCellSize
		html:dayNumber
		style:"text-align":"center"
		y:dayNumber*(dayCellSize+gutter)
		
	day.style["padding-top"]=dayCellSize/3 + "px"
	day.style["font-size"]="30pt"
		