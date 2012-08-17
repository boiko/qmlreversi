// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

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
    }

    MouseArea {
        anchors.fill: parent

        onClicked: square.clicked()
    }
}
