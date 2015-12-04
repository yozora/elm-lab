module Render2d (render) where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (Element)
import Dict exposing (Dict, empty)
import Array exposing (Array)

import Data exposing (..)

blockDim = 40
rows = 22
cols = 12


toColor : TetrominoColour -> Color
toColor tcolor =
  case tcolor of
    Cyan -> Color.rgb 0 255 255
    Yellow -> Color.darkYellow
    Purple -> Color.darkPurple
    Green -> Color.darkGreen
    Red -> Color.darkRed
    Blue -> Color.darkBlue
    Orange -> Color.darkOrange
    Shadow -> Color.darkCharcoal

block : Color -> Position -> List Form
block colour (x,y) =
  let xx = (-1 * (cols / 2) + (toFloat x)) * blockDim in
  let yy = (-1 * (rows / 2) + (toFloat y)) * blockDim in
  [(filled colour (square blockDim)), (outlined (solid black) (square blockDim))]
  |> List.map (move (blockDim / 2, blockDim / 2))
  |> List.map (move (xx, yy))

buildScene : Board -> List Form
buildScene board =
  Dict.toList board
  |> List.concatMap (\(pos, tcolor) -> block (toColor tcolor) pos)

render : GameState -> Element
render state =
  let scene = buildScene state.board in
  let trough =
    let ys = Array.toList <| Array.initialize (rows - 1) ((+) 1) in
    let xs = Array.toList <| Array.initialize (cols) identity in
    let ps = List.map ((,) 0) ys
          ++ (List.map ((,) <| cols - 1) ys)
          ++ (List.map (flip (,) <| 0) xs) in
        List.concatMap (block darkCharcoal) <| ps  in
  let forms = [backdrop] ++ trough ++ scene in
  collage (blockDim * cols) (blockDim * rows) forms
backdrop =
  (filled black (rect (blockDim * cols) (blockDim * rows)))
