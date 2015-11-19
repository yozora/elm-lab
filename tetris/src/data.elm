module Data (TetrominoColour(Cyan ,Yellow,Purple,Green
                            ,Red,Blue,Orange,Shadow)
            ,TetrominoShape(Line,Square,ZPiece,SPiece
                           ,JPiece,LPiece,TPiece)
            ,Tetromino
            ,Board
            ,Position
            ,Cursor
            ,GameState) where

import Dict exposing (Dict)

type TetrominoColour
    = Cyan
    | Yellow
    | Purple
    | Green
    | Red
    | Blue
    | Orange
    | Shadow

type TetrominoShape
    = Line
    | Square
    | ZPiece
    | SPiece
    | JPiece
    | LPiece
    | TPiece

type alias Tetromino = (TetrominoShape, TetrominoColour)

type alias Board = Dict Position TetrominoColour

type alias Position = (Int, Int)

type alias Cursor =
  { tetromino : Tetromino
  , rotation : Int
  , position : Position
  }

type alias GameState =
  { board : Board
  , cursor: Maybe Cursor
  , next : Tetromino
  , paused: Bool
  }
