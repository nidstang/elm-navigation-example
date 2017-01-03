module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Navigation


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = (\_ -> ( Model Home, Cmd.none ))
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


type Page
    = Home
    | About
    | Contact


type alias Model =
    { page : Page
    }


type Msg
    = UrlChange Navigation.Location


getPage : String -> Page
getPage hash =
    case hash of
        "#home" ->
            Home

        "#about" ->
            About

        "#contact" ->
            Contact

        _ ->
            Home


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            { model | page = (getPage location.hash) } ! [ Cmd.none ]


viewLinks : String -> Html Msg
viewLinks name =
    li [] [ a [ href ("#" ++ name) ] [ text name ] ]


view : Model -> Html Msg
view model =
    div []
        [ menu
        , content model
        ]


menu : Html Msg
menu =
    ul [] (List.map viewLinks [ "home", "about", "contact" ])


content : Model -> Html Msg
content model =
    case model.page of
        Home ->
            h1 [] [ text "Home page!" ]

        About ->
            h1 [] [ text "About page!" ]

        Contact ->
            h1 [] [ text "Contact page!" ]
