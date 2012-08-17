// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Grid {
    id: grid
    columns: 8
    rows: columns
    anchors.centerIn: parent

    property string turn: "black"

    function square(row, col) {
        if (row >= rows || col >= columns) {
            return null;
        }

        return grid.childAt(col*50+10, row*50+10);
    }

    function nextPlayer() {
        if (turn == "black") {
            turn = "white";
        } else {
            turn = "black";
        }
    }

    Repeater {
        model: columns * rows

        Square {
            state: "empty"
            width: 50
            height: 50

            row: Math.floor(modelData/grid.columns)
            col: modelData % grid.columns

            onClicked: {
                if (state != "empty") {
                    return;
                }

                state = turn;
                nextPlayer();
            }
        }
    }
}
