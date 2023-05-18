import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    visible: true
    width: 480
    height: 480

    Canvas {
        id: clock
        anchors.fill: parent

        Rectangle {
            id: hourHand
            width: 2
            height: parent.height * 0.2
            color: "black"
            antialiasing: true
            transformOrigin: Item.Bottom
            anchors.bottom: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: (360/12) * ((new Date()).getHours() + (new Date()).getMinutes() / 60)
        }

        Rectangle {
            id: minuteHand
            width: 1
            height: parent.height * 0.3
            color: "black"
            antialiasing: true
            transformOrigin: Item.Bottom
            anchors.bottom: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: (360/60) * (new Date()).getMinutes() + (360/3600) * (new Date()).getSeconds()
        }

        Rectangle {
            id: secondHand
            width: 1
            height: parent.height * 0.4
            color: "red"
            antialiasing: true
            transformOrigin: Item.Bottom
            anchors.bottom: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: (360/60) * (new Date()).getSeconds()
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            hourHand.rotation = (360/12) * ((new Date()).getHours() + (new Date()).getMinutes() / 60);
            minuteHand.rotation = (360/60) * (new Date()).getMinutes() + (360/3600) * (new Date()).getSeconds();
            secondHand.rotation = (360/60) * (new Date()).getSeconds();
        }
    }

    Component.onCompleted: {
        if (width == height) {
            visibility = Window.FullScreen
        }
    }
}
