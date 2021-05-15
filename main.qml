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

    Variable {
        id: variable
    }

    //variables
    property real alcLevel: 0.25
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
    }

    ListModel {
        id: alcLevelHistory
    }

    //functions
    function addBeverage(size, perc, selectedDrinkStart,drinkType,unitSystem) {
        var alcMass
        alcMass = convertToMass(size,perc,unitSystem)
        var drinkCurve
        drinkCurve = calculateCurve(size,perc,selectedDrinkStart,drinkType,alcMass)
        drinkList.append({"size": size, "perc": perc, "time": selectedDrinkStart, "drinkType" : drinkType, "alcMass" : alcMass,"drinkCurve" : drinkCurve})
        // listan maste sorteras pa klockslag, finns det inget snabbsatt att gora det pa? typ drinkList.sort(time)
        drunkList = calculateHistory(drinkList)

    }

    function calculateCurve(size,perc,selectedDrinkStart,drinkType,alcMass) {
        var consumptionRate
        if (drinkList.drinkType === "Beer"){
            consumptionRate = 30 //min
        }
        else if (drinkList.drinkType === "Wine"){
            consumptionRate = 30 //min
        }
        else if (drinkList.drinkType === "Shot"){
            consumptionRate = 10 //min
        }
        else if (drinkList.drinkType === "Cocktail"){
            consumptionRate = 20 //min
        }

        var drinkCurve
        var bac = 0
        var time = selectedDrinkStart
        var end = Date()+24*60 // 24 timmar fran nu

        drinkCurve.append({"time":time, "bac":bac}) //Lagg till nollan

        for (time = selectedDrinkStart ; time < (Date()+24+60); time++) {
            drinkingPeriod = time - selectedDrinkStart // i minuter

            var alcMassScaled
            if (drinkingPeriod > consumptionRate)
                alcMassScaled = alcMass
            else
                alcMassScaled = drinkingPeriod / consumptionRate


            bac = widmark(alcMassScaled,drinkingPeriod)
            if (bac>= 0)
                drinkCurve.append({"time":time, "bac":bac})


        }
    }

    function widmark(alcMass,drinkingPeriod) {
        var WT // body weight in kg
        if (unitSystem==="US"){
            WT = profileWeight*0.453592
        }
        else {
            WT = profileWeight
        }

        var bac = alcMass/(bodyWaterConstant*WT)-metabolismRate*drinkingPeriod/60

        return {bac}


    }


    function calculateHistory(drinkList) {
        var startOfPeriod = drinkList.get(0).time
        now = new Date()
        var endOfPeriod = now + 24*60 //plussar pa 24 timmar
        var drunkList

        for (var n = startOfPeriod ; n < endOfPeriod;n++) { //loopar pa minuter sedan startOfPeriod
            var bacTmp = 0
            for(var x = 0 ; x < drinkList.count;x++) { // loopar pa drinkList
                if (n >= drinkList.get(x).drinkCurve.get(0).time && n<= drinkList.get(x).drinkCurve.get(drinkList.get(x).drinkCurve.count).time) {
                    for(var y = 0 ; y < drinkList.get(x).drinkCurve.count;y++){
                        if (n===drinkList.get(x).drinkCurve.get(y).time) {
                            bacTmp += drinkList.get(x).drinkCurve.get(y).bac
                        }
                    }
                }
            }
            drunkList.append({"time":n, "bac":bacTmp})
        }
        return {drunkList}
    }

    function saveToFile(){
        //spara
    }

    Timer {
        running: true
        interval: 60000
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
        // converts to alcmass in gram
        var alcMass
        var volym // ml
        var volym_ethanol
        var mass_ethanol
        var density_ethanol = 0.789 // gram per ml

        if (unitSystem === "US") {
            volym = size*29.5735
        }
        else{
            volym = size
        }

        volym_ethanol = volym * perc // ml
        alcMass = volym_ethanol * density_ethanol // gram

        console.log(alcMass)
        return{alcMass}
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
