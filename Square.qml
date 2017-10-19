 import QtQuick 2.9

Rectangle {
    id: square
    signal clicked

    property int row: 0
    property int col: 0

    width: 50
    height: 50
    border.color: "black"
    color: "#ebecad"

    states: [
        State {
            name: "empty"
            PropertyChanges { target: coin; visible: false }
        },
        State {
            name: "black"
            PropertyChanges { target: coin; visible: true; color: "black" }
        },
        State {
            name: "white"
            PropertyChanges { target: coin; visible: true; color: "white" }
        }
    ]

    state: "empty"

    Rectangle {
        id: coin

        anchors.fill: parent
        anchors.margins: 3
        radius: Math.min(width, height)
        color: "black"
        smooth: true
        opacity: visible ? 1 : 0

        Behavior on color {
            ColorAnimation {
                duration: 150
            }
        }

        Behavior on opacity {
            PropertyAnimation {
                duration: 150
            }
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: square.clicked()
    }
}
