module Render2d (render) where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (Element)
import Dict exposing (Dict, empty)

import Data exposing (..)

blockDim = 40


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

block : (Int, Int) -> Color -> Position -> List Form
block (rows, cols) colour (x,y) =
  let xx = (-1 * (cols // 2) + x) * blockDim in
  let yy = (-1 * (rows // 2) + y) * blockDim in
  [(filled colour (square blockDim)), (outlined (solid black) (square blockDim))]
  |> List.map (move (blockDim / 2, blockDim / 2))
  |> List.map (move (xx |> toFloat, yy |> toFloat))

buildScene : (Int, Int) -> Board -> List Form
buildScene dims board =
  Dict.toList board
  |> List.concatMap (\(pos, tcolor) -> block dims (toColor tcolor) pos)

render : (Int, Int) -> GameState -> Element
render (rows, cols) state =
  let block' = block (rows, cols) in
  let scene = buildScene (rows, cols) state.board in
  let forms = [backdrop (rows, cols)] ++ scene in
  collage (blockDim * cols) (blockDim * rows) forms

backdrop: (Int, Int) -> Form
backdrop (rows, cols) =
  let (rows', cols')
        = ((rows |> toFloat), (cols |> toFloat)) in
  (filled black (rect (blockDim * cols') (blockDim * rows')))
