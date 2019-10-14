module Page.Form exposing (Model, Msg, init, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- model


type alias Model =
    { key : Nav.Key
    , mode : Mode
    , titleString : String
    , input : String
    , buttonLabel : String
    }


type Mode
    = Enter
    | Confilm



-- init


init : Nav.Key -> Model
init key =
    Model key Enter "好きなことばを入力してみてください" "" "確認"



-- update


type Msg
    = Input String
    | Submit Mode Nav.Key


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input input ->
            ( { model | input = input }, Cmd.none )

        Submit Enter key ->
            ( { model
                | mode = Confilm
                , titleString = "「" ++ model.input ++ "」と入力されましたけど？"
                , buttonLabel = "これでよし"
              }
            , Cmd.none
            )

        Submit Confilm key ->
            ( model, Nav.pushUrl key "thanks" )



-- view


view : Model -> Html Msg
view model =
    div []
        [ section [ class "hero is-primary" ]
            [ div [ class "hero-body" ]
                [ div [class "container"]
                    [ h1 [ class "title" ] [ text model.titleString ] ]
                ]
            ]
        , section [ class "section" ]
            [ div [ class "box" ]
                [ div [ class "field" ]
                    [ case model.mode of
                        Enter ->
                            div [ class "control" ]
                                [ textarea
                                    [ class "textarea"
                                    , rows 10
                                    , placeholder "ここに入力"
                                    , value model.input
                                    , onInput Input
                                    ]
                                    []
                                ]

                        Confilm ->
                            p [] [ text model.input ]
                    ]
                , div []
                    [ button
                        [ class "button is-info is-medium"
                        , disabled (String.isEmpty <| String.trim model.input)
                        , onClick (Submit model.mode model.key)
                        ]
                        [ text model.buttonLabel ]
                    ]
                ]
            ]
        ]
