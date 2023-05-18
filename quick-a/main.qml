import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    visible: true
    width: 480
    height: 480
    visibility: Screen.width === Screen.height ? Window.FullScreen : Window.Windowed

    property date now

    Hand {
        id: hourHand
        width: 2
        length: 0.4
        color: "black"
        rotation: (now.getHours() + now.getMinutes() / 60) * 360 / 12
    }

    Hand {
        id: minuteHand
        width: 1
        length: 0.6
        color: "black"
        rotation: (now.getMinutes() + now.getSeconds() / 60) * 360 / 60;
    }

    Hand {
        id: secondHand
        width: 1
        length: 0.8
        color: "red"
        rotation: (now.getSeconds() + now.getMilliseconds() / 1000) * 360 / 60
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            now = new Date()
        }
    }
}
