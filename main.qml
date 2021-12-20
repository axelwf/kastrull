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
    property alias alcLevelHistory: drinkList

    Variable {
        id: variable
    }

    //variables
    property real alcLevel: 0
    property bool alcLevelIsRising: true


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

    ListModel {
        id: alcLevelHistory
        // format: ListElement {bac: [real]; time: [timestamp]}
    }

    //functions
    function addBeverage(size, perc, selectedDrinkStart,drinkType,unitSystem) {
        var alcMass = convertToMass(size,perc,unitSystem)
        var drinkCurve = calculateCurve(size,perc,selectedDrinkStart,drinkType,alcMass)
        drinkList.append({"size": size, "perc": perc, "time": selectedDrinkStart, "drinkType" : drinkType, "alcMass" : alcMass,"drinkCurve" : drinkCurve})

        // listan maste sorteras pa klockslag, finns det inget snabbsatt att gora det pa? typ drinkList.sort(time)
        calculateHistory(drinkList)
        console.log(alcLevelHistory)
        for(var x = 0 ; x < alcLevelHistory.count;x++){
            console.log(alcLevelHistory.get(x).time + "," + alcLevelHistory.get(x).bac )
        }

//        dumpToFile()

    }

    function dumpToFile() {
        /// write to file
//        var txtFile = "c:\Users\erikb\Documents\TMP\dump.txt";
//        var s = "";
//        for(var x = 0 ; x < alcLevelHistory.count;x++) {
//            s+=',' + String(alcLevelHistory.get(x).bac)
//        }
//        console.log(s)
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

        var drinkCurve =[]
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






    function calculateHistory(drinkList) {
        alcLevelHistory.clear()
        var startOfPeriod = drinkList.get(0).time
        for (var i = 1; i < drinkList.count; i++) {
            if (drinkList.get(i).time < startOfPeriod) startOfPeriod = drinkList.get(i).time
        }
        var endOfPeriod = dateToMin(new Date()) + 24*60 //plussar pa 24 timmar
        console.log(drinkList.get(0).drinkCurve.get(0).time)
        for (var n = startOfPeriod ; n < endOfPeriod;n++) { //loopar pa minuter sedan startOfPeriod
            var bacTmp = 0
            for(var x = 0 ; x < drinkList.count;x++) { // loopar pa drinkList
                var last = drinkList.get(x).drinkCurve.count-1
                if (n >= drinkList.get(x).drinkCurve.get(0).time && n<= drinkList.get(x).drinkCurve.get(last).time) {
                    for(var y = 0 ; y < drinkList.get(x).drinkCurve.count;y++){
                        if (n===drinkList.get(x).drinkCurve.get(y).time) {
                            bacTmp += drinkList.get(x).drinkCurve.get(y).bac
                        }
                    }
                }
            }
            var bacTot = bacTmp - variable.metabolismRate*(n-startOfPeriod)/60
            if (bacTot<0) bacTot = 0
            alcLevelHistory.append({"time":n, "bac":bacTot})
        }


    }

    function saveToFile(){
        //spara
    }

    Timer {
        running: true
        interval: 60000
        //onTriggered: calculatefylla()
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


//        for(var n = 0 ; n < drinkList.count;n++){
////            console.log(drinkList.get(n).size)
////            console.log(drinkList.get(n).perc)
////            console.log(drinkList.get(n).time)
////            console.log(drinkList.get(n).drinkType)
////            console.log(metabolismRate)

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
