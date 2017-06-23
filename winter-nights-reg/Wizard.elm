module Wizard exposing (Model)

type alias Model a =
  { zero: a
  , step : a
  , default : a
  , prev : List a
  , next : List a
  }
