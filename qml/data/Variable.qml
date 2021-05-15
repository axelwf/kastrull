import QtQuick 2.0

Item {
    property int weight : 178
    property bool isMan: true
    property int selectedDrinkType: 0
    //0 = beer, 1 = wine, 2 = shot, 3 = cocktail
    property int selectedDrinkSize: 12
    property real selectedDrinkPercentage: 6

    property real metabolismRate : {
        if(isMan) {
            0.015
        }
        else {
            0.017
        }
    }
    property real bodyWaterConstant : {
        if(isMan) {
            0.58
        }
        else {
            0.49
        }
    }

}
