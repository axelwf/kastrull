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
        var standardDrinks
        standardDrinks = convertToStandardDrinks(size,perc,unitSystem)
        drinkList.append({"size": size, "perc": perc, "time": selectedDrinkStart, "drinkType" : drinkType, "standardDrinks" : standardDrinks})
        // listan maste sorteras pa klockslag, finns det inget snabbsatt att gora det pa? typ drinkList.sort(time)
    }

    function calculatefylla() {
        //calc nytt värde
        //alcLevel = 0.75
        alcLevelHistory.append()

        if (alcLevel == 0){
            saveToFile()
            drinkList.clear()
        }
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

    function bloodAlcContent(){
        var now
        var startTime
        now = new Date()
        var consumtionArray = []


        for(var n = 0 ; n < drinkList.count;n++){
//            console.log(drinkList.get(n).size)
//            console.log(drinkList.get(n).perc)
//            console.log(drinkList.get(n).time)
//            console.log(drinkList.get(n).drinkType)
//            console.log(metabolismRate)
            if (n === 0){
                startTime = drinkList.get(n).time
            }

            var consumptionRate
            if (drinkList.drinkType === "Beer"){
                consumptionRate = 30 //min
            }




            if (n < drinkList.count){ //check if not last drink
                var drinkTime
                drinkTime = drinkList.get(n).time
                var nextDrinkTime
                nextDrink = drinkHistory.get(n+1).time
                var timeDiff // diff in 1min intervalls
                timeDiff = Math.floor((nextDrink-start_time)/(1000*60))
//                for(time = start_time; ,)
            }

        }
    }

    function widmark(standardDrinks,drinkingPeriod) {
        var WT // body weight in kg
        if (unitSystem==="US"){
            WT = profileWeight*0.453592
        }
        else {
            WT = profileWeight
        }

        var bac =(0.806*standardDrinks*1.2)/(bodyWaterConstant*WT-metabolismRate*drinkingPeriod)

        return {bac}

    }

    function convertToStandardDrinks(size,perc,unitSystem){
        // converts to number of standard drinks. One standard drink is 10gr of ethanol
        var standardDrinks
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
        mass_ethanol = volym_ethanol * density_ethanol // gram
        standardDrinks = mass_ethanol / 10
        console.log(standardDrinks)
        return{standardDrinks}
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
