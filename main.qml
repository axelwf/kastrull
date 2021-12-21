import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import "./qml/mainView"
import "./qml/data"


ApplicationWindow {
    id: main
    visible: true
    // 16:9 portrait
    height: 720
    width: 405
    visibility: ApplicationWindow.AutomaticVisibility
    title: qsTr("Kastrull")

    property alias drinkList: drinkList
//    property alias intakeCurve: intakeCurve
//    property alias alcLevelHistory: alcLevelHistory

    Variable {
        id: variable
    }

    //variables
    property real alcLevel: 0
    property real bacStart: 0
    property bool alcLevelIsRising: true
    property variant intakeCurve: []
    property variant alcLevelHistory: []
    property string unitSystem : "US"
    property string sizeUnit: {
        if(unitSystem == "US"){
            "oz"
        }
        else {
            "ml"
        }
    }

    property int drinkTimeBeer: 30 //min


//    property var now : new Date()



    //data structures
    ListModel {
        id: drinkList
        // format: ListElement {size: [int]; perc: [real]; time: [timestamp]; drinkType: [int]}
    }

//    ListModel {
//        id: c
//        // format: ListElement {bac: [real]; time: [timestamp]}
//    }

//    ListModel {
//        id: intakeCurve
//        // format: ListElement {bac: [real]; time: [timestamp]}
//    }

    //functions
    function addBeverage(size, perc, selectedDrinkStart,drinkType,unitSystem) {
        var alcMass = convertToMass(size,perc,unitSystem)
        var drinkCurve = calculateCurve(size,perc,selectedDrinkStart,drinkType,alcMass)
        drinkList.append({"size": size, "perc": perc, "time": selectedDrinkStart, "drinkType" : drinkType, "alcMass" : alcMass})
        sumUpIntake(drinkCurve)
        calculateHistory()
        calculatefylla()
    }

    function update() {
        sumUpIntake([])
        calculateHistory()
        calculatefylla()

    }

    function sumUpIntake(drinkCurve) {
        var now = dateToMin(new Date())
        var before = now-24*60
        var end = now+24*60 // 24 timmar fran nu
        var bac = 0
        var newIntakeCurve =[]
        var bacPrev = 0
        for(var c = before ; c < end; c++) {
            var bac1 = findTimeStamp(c,drinkCurve)
            var bac2 = findTimeStamp(c,intakeCurve)
            bac = bac1+bac2
            if((bac) < bacPrev){
                bac = bacPrev
            }
            bacPrev = bac
            newIntakeCurve.push({"time":c, "bac":bac})
        }
        intakeCurve = newIntakeCurve
    }
    function findTimeStamp(c,curve){
        var bac = 0
        for(var x = 0; x < curve.length; x++) {
            if (curve[x].time === c) {
                bac = curve[x].bac
                break
            }
        }
        return bac
    }

    function dumpToFile() {
        /// write to file
//        var txtFile = "c:\Users\erikb\Documents\TMP\dump.txt";
//        var s = "";
//        for(var x = 0 ; x < alcLevelHistory.count;x++) {
//            s+=',' + String(alcLevelHistory.get(x).bac)
//        }

//        const fs = require('fs');


//        fs.writeFile('/Users/joe/test.txt', s, err => {
//          if (err) {
//            console.error(err)
//            return
//          }


    }

    function dateToMin(date) {
        var dateMin = Math.round(date.getTime()/(1000*60)) //get num millisec
        return dateMin

    }

    function calculateCurve(size,perc,selectedDrinkStart,drinkType,alcMass) {
        var consumptionRate
        if (drinkType === 0){
            consumptionRate = 30 //min
        }
        else if (drinkType === 1){
            consumptionRate = 30 //min
        }
        else if (drinkType === 2){
            consumptionRate = 10 //min
        }
        else if (drinkType === 3){
            consumptionRate = 20 //min
        }

        var drinkCurve =[];
        var now = dateToMin(new Date())
        var end = now+24*60 // 24 timmar fran nu
        var t
        for (t = selectedDrinkStart ; t < end; t++) {
            var drinkingPeriod = t - selectedDrinkStart // i minuter

            var alcMassScaled
            if (drinkingPeriod > consumptionRate)
                alcMassScaled = alcMass
            else
                alcMassScaled = (drinkingPeriod / consumptionRate)*alcMass


            var WT // body weight in kg
            if (unitSystem==="US"){
                WT = variable.weight*0.453592
            }
            else {
                WT = variable.weight
            }

            var bac = 100*alcMassScaled/(variable.bodyWaterConstant*WT)
            drinkCurve.push({"time":t, "bac":bac})
        }
        return drinkCurve
    }






    function calculateHistory() {
        var startOfPeriod = intakeCurve[0].time
        var newAlcLevelHistory = []
        newAlcLevelHistory.push({"time":startOfPeriod, "bac":bacStart})

        var bacPrev = bacStart
        for (var n = 1 ; n < (intakeCurve.length);n++){
            var bac = 0
            if (bacPrev === 0){
                bac = intakeCurve[n].bac - intakeCurve[n-1].bac
                bacPrev = bac
            }
            else {
                bac = bacPrev + (intakeCurve[n].bac - intakeCurve[n-1].bac) - variable.metabolismRate*(intakeCurve[n].time-intakeCurve[n-1].time)/60
                if (bac<0) bac = 0
                bacPrev = bac
            }
            alcLevelHistory.push({"time":intakeCurve[n].time, "bac":bac})
//            console.log(intakeCurve[n].time+","+bac)
        }


//        var startOfPeriod = drinkList.get(0).time

//        var endOfPeriod = dateToMin(new Date()) + 24*60 //plussar pa 24 timmar
//        for (var n = startOfPeriod ; n < endOfPeriod;n++) { //loopar pa minuter sedan startOfPeriod
//            var bacTmp = 0
//            for(var x = 0 ; x < drinkList.count;x++) { // loopar pa drinkList
//                var last = drinkList.get(x).drinkCurve.count-1
//                if (n >= drinkList.get(x).drinkCurve.get(0).time && n<= drinkList.get(x).drinkCurve.get(last).time) {
//                    for(var y = 0 ; y < drinkList.get(x).drinkCurve.count;y++){
//                        if (n===drinkList.get(x).drinkCurve.get(y).time) {
//                            bacTmp += drinkList.get(x).drinkCurve.get(y).bac
//                        }
//                    }
//                }
//            }
//            var bacTot = bacTmp - variable.metabolismRate*(n-startOfPeriod)/60
//            if (bacTot<0) bacTot = 0
//            alcLevelHistory.append({"time":n, "bac":bacTot})

//        }


    }

    function saveToFile(){
        //spara
    }

    function calculatefylla(){
        console.log('lll')
        var now = 2*24*60/2-1
        alcLevel = alcLevelHistory[now].bac.toFixed(3)
//        console.log(alcLevel)
//        console.log(alcLevelHistory[now].bac.toFixed(3))
//        for (var x = 0 ; x < alcLevelHistory.length;x++) {
//            console.log(x + "," + alcLevelHistory[x].bac)
//        }

        if(alcLevel < alcLevelHistory[now+1].bac){
            alcLevelIsRising = true
            }
        else {
            alcLevelIsRising = false
            }


    }

    Timer {
        running: true
        interval: 6000
        onTriggered: calculatefylla()
    }

    Colors {
        id: colors
    }  

//    function bloodAlcContent(){
//        var now
//        var startTime
//        now = new Date()
//        startTime =
//        var consumtionArray = []




//            var consumptionRate
//            if (drinkList.drinkType === "Beer"){
//                consumptionRate = 30 //min
//            }
//            else if (drinkList.drinkType === "Wine"){
//                consumptionRate = 30 //min
//            }
//            else if (drinkList.drinkType === "Shot"){
//                consumptionRate = 10 //min
//            }
//            else if (drinkList.drinkType === "Cocktail"){
//                consumptionRate = 20 //min
//            }



//            if (n < drinkList.count){ //check if not last drink
//                var drinkTime
//                drinkTime = drinkList.get(n).time
//                var nextDrinkTime
//                nextDrink = drinkHistory.get(n+1).time
//                var timeDiff // diff in 1min intervalls
//                timeDiff = Math.floor((nextDrink-start_time)/(1000*60))
////                for(time = start_time; ,)
//            }

//        }
//    }



//    }

    function convertToMass(size,perc,unitSystem){
        // converts to alcmass in kg
        var alcMass
        var volym // ml
        var volym_ethanol
        var density_ethanol = 789 // kg / m3

        if (unitSystem === "US") {
            volym = size*29.5735/1000000
        }
        else{
            volym = size
        }

        volym_ethanol = volym * perc/100 // ml
        alcMass = volym_ethanol * density_ethanol // kg
        return alcMass
    }

    header: ToolBar {
            RowLayout {
                anchors.fill: parent
                ToolButton {
                    text: qsTr("‹")
                    onClicked: stack.pop()
                    font.pixelSize: 44
                }
                Label {
                    text: "Kastrull"
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                    font.pixelSize: 24
                }
                ToolButton {
                    text: qsTr("⋮")
                    onClicked: menu.open()
                    font.pixelSize: 44
                }
            }
        }

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: MainPageVertical{}
    }

    Splashscreen {
        id: splash
        width: main.width
        height: main.height
    }

    Timer {
        id: splashTimer
        onTriggered: splash.opacity = 0
        interval: 1000
    }

    onClosing: {
        if(stack.depth > 1) {
            close.accepted = false;
            stack.pop()
        }
        else {
            close.accepted = true;
        }
    }

    Component.onCompleted: {
        splashTimer.start()
    }

}
