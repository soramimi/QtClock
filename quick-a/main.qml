import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    visible: true
    width: 480
    height: 480

    property double hour: 0
    property double minute: 0
    property double second: 0
    property double millisec: 0

    Hand {
        id: hourHand
        width: 2
        length: 0.4
        color: "black"
        rotation: (hour + minute / 60) * 360 / 12
    }

    Hand {
        id: minuteHand
        width: 1
        length: 0.6
        color: "black"
        rotation: (minute + second / 60) * 360 / 60;
    }

    Hand {
        id: secondHand
        width: 1
        length: 0.8
        color: "red"
        rotation: (second + millisec / 1000) * 360 / 60
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            var now = new Date()
            hour = now.getHours()
            minute = now.getMinutes()
            second = now.getSeconds()
            millisec = now.getMilliseconds()
        }
    }

    Component.onCompleted: {
        if (Screen.width === Screen.height) {
            visibility = Window.FullScreen
        }
    }
}
