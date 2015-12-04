module Main where

import Dict exposing (Dict, empty)

import Data exposing (..)
import Render2d exposing (render)

import Debug

emptyBoard = Dict.fromList []

defaultState : GameState
defaultState =
  { board = emptyBoard
  , cursor = Nothing
  , next = (Line, Red)
  , paused = False
  }

tetrominoOffset : TetrominoShape -> List Position
tetrominoOffset piece =
  case piece of
    Line   -> [(-1,0), (0,0), (1,0), (2,0)]
    Square -> [(0,0), (1,0), (0,1), (1,1)]
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
  let newBoard =
        defaultState.board
        |> placeTetromino (Square, Cyan) (5,1)
        |> placeTetromino (Square, Purple) (1,2)
        |> placeTetromino (Line, Red) (2,1) in
  let state = { defaultState | board <- newBoard } in
  render state
