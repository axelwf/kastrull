import QtQuick 2.0

Item {
    property int weight : 178
    property bool isMan: true



    property real metabolismRate : {
        if(profileIsMan) {
            0.015
        }
        else {
            0.017
        }
    }
    property real bodyWaterConstant : {
        if(profileIsMan) {
            0.58
        }
        else {
            0.49
        }
    }

}
