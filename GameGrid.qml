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

    function recursiveFlip(r, c, rowOffset, colOffset, color) {
        if (r >= rows || r < 0 || c >= columns || c < 0) {
            return false;
        }

        var item = square(r, c);
        if (item.state == color ) {
            return true;
        } else if (item.state == "empty") {
            return false;
        }

        // if the recursion returns true, we need to flip the square color
        if (recursiveFlip(r+rowOffset, c+colOffset, rowOffset, colOffset, color)) {
            item.state = color;
            return true;
        }

        return false;
    }

    function flipDirection(row, col, rowOffset, colOffset, color, justCheck) {
        // if the first item in a given direction is of the same color as the adjascent one
        // return false
        var item = square(row+rowOffset, col+colOffset);
        if (item && item.state == color) {
            return false;
        }

        return recursiveFlip(row+rowOffset, col+colOffset, rowOffset, colOffset, color);
    }

    function flipSquares(row, col, color, justCheck) {
        var flipped = false;
        // we need to check in all directions
        flipped |= flipDirection(row, col,  0, -1, color); // left
        flipped |= flipDirection(row, col,  0,  1, color); // right
        flipped |= flipDirection(row, col, -1, -1, color); // topLeft
        flipped |= flipDirection(row, col, -1,  0, color); // top
        flipped |= flipDirection(row, col, -1,  1, color); // topRight
        flipped |= flipDirection(row, col,  1,  0, color); // bottom
        flipped |= flipDirection(row, col,  1, -1, color); // bottomLeft
        flipped |= flipDirection(row, col,  1,  1, color); // bottomRight

        return flipped;
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
                if (state != "empty" || !flipSquares(row, col, turn)) {
                    return;
                }

                state = turn;
                updateStats();
                nextPlayer();
            }
        }
    }
}
