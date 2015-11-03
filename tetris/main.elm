import Html exposing (Html, Attribute, node, span, div)
import Html.Attributes exposing (style)
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (Element)
import Dict exposing (Dict, empty)

type TetrominoColour
    = Red
    | Orange
    | Green
    | Blue
    | Indigo
    | Violet
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

type Board = Dict Position TetrominoColour

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

emptyBoard = []

defaultState =
  { board = empty
  , cursor = Nothing
  , next = (Line, Red)
  , paused = False
  }

styleBold =
  style [ ("font-weight", "bold") ]

shape = filled red (square 50)
        
main = collage 500 500 [shape, (move (-50,50) shape)]
--  div []
--    [ (div [styleBold] [Html.text "Tetris"])
--    , (node "hr" [] [])
--    , (div [] [Html.text <| toString defaultState])
--    ]
