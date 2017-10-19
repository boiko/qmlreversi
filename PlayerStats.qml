 import QtQuick 2.9

Rectangle {
    id: playerRect
    property string playerColor
    property bool currentPlayer: false
    property alias playerName: name.text
    property int squareCount: 0

    width: 100
    height: 50
    color: playerColor

    Column {
        anchors.centerIn: parent
        Text {
            id: name
            font.bold: true
            color: playerRect.playerColor == "black" ? "white" : "black"
        }

        Text {
            id: count
            text: playerRect.squareCount
            color: name.color
        }
    }

    Rectangle {
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(0, 1, 0, 0) }
            GradientStop { position: 1.0; color: "green" }
        }
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: parent.height/3
        smooth: true
        opacity: currentPlayer ? 1 : 0

        Behavior on opacity {
            PropertyAnimation {
                duration: 150
            }
        }
    }
}
