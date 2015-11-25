module Main where

import Dict exposing (Dict, empty)

import Data exposing (..)
import Render2d exposing (render)

import Debug

emptyBoard = []

defaultState : GameState
defaultState =
  { board = Dict.fromList
            [ ((1,1), Red)
            , ((5,5), Blue)
            ]
  , cursor = Nothing
  , next = (Line, Red)
  , paused = False
  }

tetrominoOffset : TetrominoShape -> List Position
tetrominoOffset piece =
  case piece of
    Line   -> [(-1,0), (0,0), (1,0), (2,0)]
    Square -> []
    ZPiece -> []
    SPiece -> []
    JPiece -> []
    LPiece -> []
    TPiece -> []

placeTetromino : Tetromino -> Position -> Board -> Board
placeTetromino (tShape, tColour) (px, py) currentBoard =
  let offsets = tetrominoOffset tShape in
  let ps = List.map (\ (ox, oy) -> ((px + ox), (py + oy))) offsets in
  let blocks = List.map ((flip (,)) tColour) ps in
  Dict.union currentBoard (Dict.fromList blocks)
              
main =
  let newBoard = placeTetromino (Line, Red) (5,10) defaultState.board in
  let state = { defaultState | board <- newBoard } in
  render state
