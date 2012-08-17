// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    width: grid.width + 20
    height: column.height + 20

    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#977568"
        }

        GradientStop {
            position: 1
            color: "#3a240b"
        }
    }

    Column {
        id: column
        anchors.centerIn: parent

        width: grid.width

        Row {
            anchors.left: parent.left
            anchors.right: parent.right
            height: childrenRect.height

            PlayerStats {
                id: player1
                width: parent.width / 2
                playerColor: "black"
                playerName: "Player 1"
                squareCount: grid.blackSquares
                currentPlayer: grid.turn == playerColor
            }

            PlayerStats {
                id: player2
                width: parent.width / 2
                playerColor: "white"
                playerName: "Player 2"
                squareCount: grid.whiteSquares
                currentPlayer: grid.turn == playerColor
            }
        }

        GameGrid {
            id: grid
            anchors.left: parent.left
            // columns need to be even
            columns: 8
            // rows need to be even
            rows: 8

            Component.onCompleted: {
                var midRow = rows / 2;
                var midCol = columns / 2;
                square(midRow, midCol).state = "white";
                square(midRow-1, midCol-1).state = "white";
                square(midRow-1, midCol).state = "black";
                square(midRow, midCol-1).state = "black";
                updateStats();
            }
        }
    }
}
