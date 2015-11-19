module Main where

import Dict exposing (Dict, empty)

import Data exposing (..)
import Render2d exposing (render)

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


main =
  render defaultState.board
