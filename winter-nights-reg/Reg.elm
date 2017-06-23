import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy, lazy2)
import String
import List
import Wizard as Wizard

main =
  App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }


-- MODEL

type alias Model =
  { email : String
  , personUid : Int
  , attendees : List Person
  , camping : Bool
  , electricity : Bool
  , weekendOnly : Bool
  }

type AgeGroup
  = Toddler
  | Child
  | Youth
  | Adult

type alias Person =
  { id : Int
  , name : String
  , ageGroup : AgeGroup
  , gettingFood : Bool
  , glutenFree : Bool
  , vegetarian : Bool
  }

newPerson : Int -> Person
newPerson id = Person id "" Adult False False False

emptyModel =
  Model
    ""
    0
    []
    False
    False
    False

testModel =
  Model
    "msmithgu@gmail.com"
    7
    [ Person 0 "Mark Smith" Adult True False False
    , Person 1 "Kelly Smith" Adult True True False
    , Person 2 "Dylan Wade" Adult False False True
    , Person 3 "Z" Youth True False False
    , Person 4 "Eilidh" Child True True True
    , Person 5 "Ethan" Toddler True True False
    , Person 6 "Ezri" Toddler True False False
    ]
    True
    True
    True

-- model = emptyModel
model = testModel


-- UPDATE

type Msg
  = NoOp
  | UpdateEmail String
  | ToggleElectricity
  | ToggleCamping
  | ToggleWeekendOnly
  | Delete Int
  | AddPerson
  | UpdatePersonName Int String
  | UpdatePersonAgeGroup Int AgeGroup
  | ToggleFood Int
  | ToggleGlutenFree Int
  | ToggleVegetarian Int

update msg model =
  case msg of
    NoOp ->
      model
    UpdateEmail email ->
      { model | email = email }
    ToggleCamping ->
      { model | camping = not model.camping }
    ToggleElectricity ->
      { model | electricity = not model.electricity }
    ToggleWeekendOnly ->
      { model | weekendOnly = not model.weekendOnly }
    AddPerson ->
      { model
          | attendees =
              [newPerson model.personUid] ++ model.attendees
          , personUid = model.personUid + 1
      }
    Delete id ->
      { model | attendees = List.filter (\t -> t.id /= id) model.attendees }
    UpdatePersonName id newName ->
      { model | attendees =
          List.map
            (\t ->
              if (t.id == id) then
                { t | name = newName }
              else
                t
            )
            model.attendees
      }
    UpdatePersonAgeGroup id newAgeGroup ->
      { model | attendees =
          List.map
            (\t ->
              if (t.id == id) then
                { t | ageGroup = newAgeGroup }
              else
                t
            )
            model.attendees
      }
    ToggleFood id ->
      { model | attendees =
          List.map
            (\t ->
              if (t.id == id) then
                { t | gettingFood = not t.gettingFood }
              else
                t
            )
            model.attendees
      }
    ToggleGlutenFree id ->
      { model | attendees =
          List.map
            (\t ->
              if (t.id == id) then
                { t | glutenFree = not t.glutenFree }
              else
                t
            )
            model.attendees
      }
    ToggleVegetarian id ->
      { model | attendees =
          List.map
            (\t ->
              if (t.id == id) then
                { t | vegetarian = not t.vegetarian }
              else
                t
            )
            model.attendees
      }


-- VIEW

css : String -> Html Msg
css path =
  node "link" [ rel "stylesheet", href path ] []

view model =
  div
    [ class "reg-container clearfix" ]
    [ css "style.css"
    , div
        [ class "clearfix" ]
        [ div
            [ style [("text-align", "right")] ]
            [ button
                [ style [("margin", "1em")] ]
                [text "<"]
            , button
                [ style [("margin", "1em")] ]
                [text ">"]
            ]
        , section
            [ class "reg-form" ]
            [ label
                [ class "clearfix" ]
                [ text "Your Email"
                , input
                    [ style [("float", "right")]
                    , type' "text"
                    , placeholder "you@example.net"
                    , value model.email
                    , onInput UpdateEmail
                    ] []
                ]
            , label
                [ class "clearfix" ]
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
        , section
            [ class "reg-form" ]
            [ label
                [ class "clearfix" ]
                [ text "Camping with us?"
                , input
                    [ class "toggle"
                    , type' "checkbox"
                    , checked model.camping
                    , onClick (ToggleCamping)
                    ]
                    []
                ]
            , label
                [ classList
                    [ ("clearfix", True)
                    , ("hide", not model.camping)
                    ]
                ]
                [ text "Need a camp site with electricity?"
                , input
                    [ class "toggle"
                    , type' "checkbox"
                    , checked model.electricity
                    , onClick (ToggleElectricity)
                    ]
                    []
                ]
            ]
        , lazy viewAttendees model.attendees
        , section
            [ class "reg-results-container clearfix" ]
            [ viewResults model ]
        ]
    ]

viewResults : Model -> Html Msg
viewResults model =
  let
    numAttendees = List.length model.attendees
    numAdults =
      List.length
        (List.filter
          ( \attendee -> attendee.ageGroup == Adult )
          model.attendees
        )
    numYouth =
      List.length
        (List.filter
          ( \attendee -> attendee.ageGroup == Youth )
          model.attendees
        )
    numChildren =
      List.length
        (List.filter
          ( \attendee -> attendee.ageGroup == Child )
          model.attendees
        )
    numToddlers =
      List.length
        (List.filter
          ( \attendee -> attendee.ageGroup == Toddler )
          model.attendees
        )
    mealPlans =
      List.length
        (List.filter
          ( \person -> person.gettingFood )
          model.attendees
        )
    mealPlansWithDietaryRestrictions =
      List.length
        (List.filter
          ( \attendee ->
            attendee.gettingFood && (attendee.glutenFree || attendee.vegetarian)
          )
          model.attendees
        )
  in
    div [ class "reg-results" ]
      [ table []
          [ tr []
              [ td [] [text "Your Email"]
              , td [] [text model.email]
              ]
          , tr []
              [ td [] [text "Weekend only?"]
              , td [] [text (toString model.weekendOnly)]
              ]
          , tr []
              [ td [] [text "Campsite?"]
              , td [] [text (toString model.camping)]
              ]
          , tr []
              [ td [] [text "Campsite with electricity?"]
              , td [] [text (toString (model.camping && model.electricity))]
              ]
          , tr []
              [ td [] [text "Adults"]
              , td [] [text (toString numAdults)]
              ]
          , tr []
              [ td [] [text "Youth"]
              , td [] [text (toString numYouth)]
              ]
          , tr []
              [ td [] [text "Children"]
              , td [] [text (toString numChildren)]
              ]
          , tr []
              [ td [] [text "Toddlers"]
              , td [] [text (toString numToddlers)]
              ]
          , tr []
              [ td [] [text "Meal plans"]
              , td [] [text (toString mealPlans)]
              ]
          , tr []
              [ td [] [text "Meal plans with dietary restrictions"]
              , td [] [text (toString mealPlansWithDietaryRestrictions)]
              ]
          ]
      ]

ageString : AgeGroup -> String
ageString ageGroup =
  if (ageGroup == Adult) then ""
  else " (" ++ (toString ageGroup) ++ ")"

radio : String -> Bool -> msg -> Html msg
radio value isChecked msg =
  label
    [ classList
        [ ("radio-label", True)
        , ("radio-label-selected", isChecked)
        ]
    ]
    [ input
        [ type' "radio"
        , checked isChecked
        , onClick msg
        ]
        []
    , text value
    ]

isAdult : Person -> Bool
isAdult {ageGroup} = ageGroup == Adult

isYouth : Person -> Bool
isYouth {ageGroup} = ageGroup == Youth

isChild : Person -> Bool
isChild {ageGroup} = ageGroup == Child

isToddler : Person -> Bool
isToddler {ageGroup} = ageGroup == Toddler

gettingFood : Person -> Bool
gettingFood {gettingFood} = gettingFood == True

viewAttendees : List Person -> Html Msg
viewAttendees persons =
  section
    [ class "persons-container" ]
    [ button
        [ onClick (AddPerson) ]
        [ text "Add person" ]
    , table
        [ class "persons" ]
        [ thead
            []
            [ tr
                []
                [ th [ class "name-col" ] [ text "Name" ]
                , th [ class "age-col" ] [ text "Age Group" ]
                , th [ class "food-col" ] [ text "Food?" ]
                , th [ class "gluten-col" ] [ text "Gluten Free?" ]
                , th [ class "vegetarian-col" ] [ text "Vegetarian" ]
                ]
            ]
        , Keyed.node
            "tbody"
            [ class "persons" ]
            <| List.map viewKeyedPerson persons
        ]
    ]

viewKeyedPerson : Person -> (String, Html Msg)
viewKeyedPerson person =
  ( toString person.id, lazy viewPersonRow person )

viewPersonRow : Person -> Html Msg
viewPersonRow person =
  tr
    [ class "name-col" ]
    [ td
        []
        [ button
            [ class "destroy"
            , onClick (Delete person.id)
            ]
            [ text "X" ]
        , input
            [ type' "text"
            , class "name"
            , placeholder "Name here"
            , value person.name
            , onInput (UpdatePersonName person.id)
            ] []
        ]
    , td
        [ class "age-col" ]
        [ ul
            [ class "radio" ]
            [ li [] [ radio "Adult" (isAdult person) (UpdatePersonAgeGroup person.id Adult) ]
            , li [] [ radio "Youth" (isYouth person) (UpdatePersonAgeGroup person.id Youth) ]
            , li [] [ radio "Child" (isChild person) (UpdatePersonAgeGroup person.id Child) ]
            , li [] [ radio "Toddler" (isToddler person) (UpdatePersonAgeGroup person.id Toddler) ]
            ]
        ]
    , td
        [ class "food-col" ]
        [ input
            [ class "toggle"
            , type' "checkbox"
            , checked person.gettingFood
            , onClick (ToggleFood person.id)
            ]
            []
        ]
    , td
        [ classList
            [ ("gluten-col", True)
            ]
        ]
        [ input
            [ classList
                [ ("toggle", True)
                , ("hide", not person.gettingFood)
                ]
            , type' "checkbox"
            , checked person.glutenFree
            , onClick (ToggleGlutenFree person.id)
            ]
            []
        ]
    , td
        [ classList
            [ ("vegetarian-col", True)
            ]
        ]
        [ input
            [ classList
                [ ("toggle", True)
                , ("hide", not person.gettingFood)
                ]
            , type' "checkbox"
            , checked person.vegetarian
            , onClick (ToggleVegetarian person.id)
            ]
            []
        ]
    ]

viewPersonListElement : Person -> Html Msg
viewPersonListElement person =
  li
    [ class "person" ]
    [ button
        [ class "destroy"
        , onClick (Delete person.id)
        ]
        [ text "X" ]
    , input
        [ type' "text"
        , class "name"
        , placeholder "Name here"
        , value person.name
        , onInput (UpdatePersonName person.id)
        ] []
    , ul
        [ class "radio" ]
        [ li [] [ radio "Adult" (isAdult person) (UpdatePersonAgeGroup person.id Adult) ]
        , li [] [ radio "Youth" (isYouth person) (UpdatePersonAgeGroup person.id Youth) ]
        , li [] [ radio "Child" (isChild person) (UpdatePersonAgeGroup person.id Child) ]
        , li [] [ radio "Toddler" (isToddler person) (UpdatePersonAgeGroup person.id Toddler) ]
        ]
    ]
