// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Grid {
    id: grid
    columns: 8
    rows: columns

    property int blackSquares: 0
    property int whiteSquares: 0

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

    function updateStats() {
        var black = 0, white = 0

        for(var i = 0; i < grid.children.length; ++i) {
            var item = grid.children[i];
            if (item.state == "black") {
                black++;
            } else if (item.state == "white") {
                white++;
            }
        }
        blackSquares = black;
        whiteSquares = white;
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
                updateStats();
                nextPlayer();
            }
        }
    }
}
