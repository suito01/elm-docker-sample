module Page.Thanks exposing (Model, Msg, init, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { key : Nav.Key }



-- init


init : Nav.Key -> Model
init key =
    Model key



-- update


type Msg
    = Back Nav.Key


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Back key ->
            ( model, Nav.pushUrl key "/" )



-- view


view : Model -> Html Msg
view model =
    div []
        [ section [ class "hero is-primary" ]
            [ div [ class "hero-body" ]
                [ div [ class "container" ]
                    [ h1 [ class "title" ] [ text "これだけです" ] ]
                ]
            ]
        , section [ class "section" ]
            [ div [ class "box" ]
                [ p [] [ text "ありがとうございました。" ]
                , a [ href "/" ] [ text "トップページへ" ]
                ]
            ]
        ]
