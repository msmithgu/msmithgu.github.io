import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy, lazy2)
import String
import List

main =
  App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }


-- MODEL

type alias Model =
  { email : String
  , adultGuests : List Person
  , youthGuests : List Person
  , childGuests : List Person
  , food : Bool
  , electricity : Bool
  , weekendOnly : Bool
  , dietaryRestrictions : String
  }

type alias Person =
  { id : Int
  , name : String
  }

emptyModel = Model "" [] [] [] False False False ""

testModel =
  Model
    "msmithgu@gmail.com"
    [ Person 0 "Mark Smith"
    , Person 1 "Kelly Smith"
    , Person 2 "Dylan Wade"
    ]
    [ Person 0 "Z" ]
    [ Person 0 "Eilidh"
    , Person 1 "Ethan"
    , Person 2 "Ezri"
    ]
    True
    True
    True
    "Kelly must have icecream with every meal. Ethan is on a gluten free diet."

-- model = emptyModel
model = testModel


-- UPDATE

type Msg
  = NoOp
  | UpdateEmail String
  | UpdateAdults String
  | UpdateYouth String
  | UpdateChildren String
  | ToggleFood
  | ToggleElectricity
  | ToggleWeekendOnly
  | UpdateDietaryRestrictions String

indexedPersonsFromString names =
  List.indexedMap
    (\i name -> Person i name)
    (List.filter
      (\s -> not (String.isEmpty s))
      (String.lines names)
    )

update msg model =
  case msg of
    NoOp ->
      model
    UpdateEmail email ->
      { model | email = email }
    UpdateAdults names ->
      { model | adultGuests = indexedPersonsFromString names }
    UpdateYouth names ->
      { model | youthGuests = indexedPersonsFromString names }
    UpdateChildren names ->
      { model | childGuests = indexedPersonsFromString names }
    ToggleFood ->
      { model | food = not model.food }
    ToggleElectricity ->
      { model | electricity = not model.electricity }
    ToggleWeekendOnly ->
      { model | weekendOnly = not model.weekendOnly }
    UpdateDietaryRestrictions text ->
      { model | dietaryRestrictions = text }


-- VIEW

view model =
  let
    numAdults = List.length model.adultGuests
    numYouth = List.length model.youthGuests
    numChildren = List.length model.childGuests
  in
    div [ class "reg-container" ]
      [ div [ class "reg-form" ]
        [ label [ class "clearfix" ]
            [ text "Your Email"
            , input
                [ style [("float", "right")]
                , type' "text"
                , placeholder "you@example.net"
                , onInput UpdateEmail
                ] []
            ]
        , label [ class "clearfix" ]
            [ text "Enter the Names of each person over 15 years old"
            , textarea [ onInput UpdateAdults ] []
            ]
        , label [ class "clearfix" ]
            [ text "Enter the Names of each person 11-15 years old"
            , textarea [ onInput UpdateYouth ] []
            ]
        , label [ class "clearfix" ]
            [ text "Enter the Names of each person under 10"
            , textarea [ onInput UpdateChildren ] []
            ]
        , label [ class "clearfix" ]
            [ text "Getting food?"
            , input
                [ class "toggle"
                , type' "checkbox"
                , checked model.food
                , onClick (ToggleFood)
                ]
                []
            ]
        , label [ class "clearfix" ]
            [ text "Enter any dietary restrictions for anyone in your party."
            , textarea [ onInput UpdateDietaryRestrictions ] []
            ]
        , label [ class "clearfix" ]
            [ text "Need a camp site with electricity?"
            , input
                [ class "toggle"
                , type' "checkbox"
                , checked model.electricity
                , onClick (ToggleElectricity)
                ]
                []
            ]
        , label [ class "clearfix" ]
            [ text "Attending for the weekend only?"
            , input
                [ class "toggle"
                , type' "checkbox"
                , checked model.weekendOnly
                , onClick (ToggleWeekendOnly)
                ]
                []
            ]
        ]
      , div [ class "reg-results" ]
        [ dl []
            [ dt [] [text "Your Email"]
            , dd [] [text model.email]
            , dt [] [text ("Adults (" ++ toString numAdults ++ ")")]
            , dd []
                [ Keyed.ul [] <|
                    List.map viewKeyedPerson model.adultGuests
                ]
            , dt [] [text ("Youth (" ++ toString numYouth ++ ")")]
            , dd []
                [ Keyed.ul [] <|
                    List.map viewKeyedPerson model.youthGuests
                ]
            , dt [] [text ("Children (" ++ toString numChildren ++ ")")]
            , dd []
                [ Keyed.ul [] <|
                    List.map viewKeyedPerson model.childGuests
                ]
            ]
            , dt [] [text "Food?"]
            , dd [] [text (toString model.food)]
            , dt [] [text "Dietary restrictions"]
            , dd [] [text model.dietaryRestrictions]
            , dt [] [text "Campsite with electricity?"]
            , dd [] [text (toString model.electricity)]
            , dt [] [text "Weekend only?"]
            , dd [] [text (toString model.weekendOnly)]
        ]
      ]

viewKeyedPerson : Person -> (String, Html Msg)
viewKeyedPerson person =
  ( toString person.id, lazy viewPerson person )

viewPerson : Person -> Html Msg
viewPerson person =
  li []
    [ text person.name ]
