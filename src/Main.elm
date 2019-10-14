module Main exposing (Model, Msg, init, subscriptions, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Page.Form exposing (Model, Msg, init, update, view)
import Page.Thanks exposing (Model, Msg, init, update, view)
import Route exposing (Route)
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }


type alias Model =
    { key : Nav.Key
    , page : Page
    }


type Page
    = NotFound
    | FormPage Page.Form.Model
    | ThanksPage Page.Thanks.Model


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    Model key (FormPage (Page.Form.init key))
        |> goTo (Route.parse url)


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | FormMsg Page.Form.Msg
    | ThanksMsg Page.Thanks.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            goTo (Route.parse url) model

        FormMsg formMsg ->
            case model.page of
                FormPage formModel ->
                    let
                        ( newFormModel, formCmd ) =
                            Page.Form.update formMsg formModel
                    in
                    ( { model | page = FormPage newFormModel }
                    , Cmd.map FormMsg formCmd
                    )

                _ ->
                    ( model, Cmd.none )

        ThanksMsg thanksMsg ->
            case model.page of
                ThanksPage thanksModel ->
                    let
                        ( newThanksModel, thanksCmd ) =
                            Page.Thanks.update thanksMsg thanksModel
                    in
                    ( { model | page = ThanksPage newThanksModel }
                    , Cmd.map ThanksMsg thanksCmd
                    )

                _ ->
                    ( model, Cmd.none )


goTo : Maybe Route -> Model -> ( Model, Cmd Msg )
goTo maybeRoute model =
    case maybeRoute of
        Just Route.Form ->
            ( { model | page = FormPage (Page.Form.init model.key) }, Cmd.none )

        Just Route.Thanks ->
            ( { model | page = ThanksPage (Page.Thanks.init model.key) }, Cmd.none )

        Nothing ->
            ( { model | page = NotFound }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "適当なアプリ"
    , body =
        [ case model.page of
            FormPage formModel ->
                Page.Form.view formModel
                    |> Html.map FormMsg

            ThanksPage thanksModel ->
                Page.Thanks.view thanksModel
                    |> Html.map ThanksMsg

            NotFound ->
                text "ページが見つかりません"
        ]
    }
