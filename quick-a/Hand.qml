import QtQuick 2.15

Rectangle {
    id: hand
    antialiasing: true
    height: parent.height * length / 2
    transformOrigin: Item.Bottom
    anchors.bottom: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    property double length: 1
}
