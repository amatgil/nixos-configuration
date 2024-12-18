module Main exposing (..)
import Browser
import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN

main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL

type alias Model =
    
init : Model
init =

-- UPDATE


type Msg
  = Haii


update : Msg -> Model -> Model
update msg model =
  case msg of



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ placeholder "Current guess", value model.current_guess, onInput GuessDigit ] []
    , div [] [ text (model.current_guess) ]
    ]
