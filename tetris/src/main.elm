module Main where

import Dict exposing (Dict, empty)
import Array exposing (Array)

import Data exposing (..)
import Render2d exposing (render)

import Debug

rows = 22
cols = 12
emptyBoard = Dict.fromList [] |> addTrough

defaultState : GameState
defaultState =
  { board = emptyBoard
  , cursor = Nothing
  , next = (Line, Red)
  , paused = False
  }


addTrough: Board -> Board
addTrough board =
  let ys = Array.toList <| Array.initialize (rows - 1) ((+) 1) in
  let xs = Array.toList <| Array.initialize (cols) identity in
  let ps = List.map ((,) 0) ys
          ++ (List.map ((,) <| cols - 1) ys)
          ++ (List.map (flip (,) <| 0) xs) in
  let fn = (\p -> (p, Shadow)) in
  Dict.union (Dict.fromList (List.map fn ps)) board

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
              
collisionTest : Tetromino -> Position -> Board -> Bool
collisionTest t p b =
  emptyBoard /= Dict.intersect (placeTetromino t p emptyBoard) b

main =
  let newBoard =
        defaultState.board
        |> placeTetromino (Square, Cyan) (5,1)
        |> placeTetromino (Square, Purple) (1,2)
        |> placeTetromino (Line, Red) (2,1) in
  let xx =
        Debug.log "NewBoard" <|
        collisionTest (Line, Red) (2,1) newBoard in
  let state = { defaultState | board = newBoard } in
  render (rows, cols) state
