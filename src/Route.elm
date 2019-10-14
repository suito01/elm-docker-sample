module Route exposing (Route(..), parse)

import Url exposing (Url)
import Url.Parser exposing (Parser, s, top, map, oneOf)

type Route
    = Form
    -- | Confilm
    | Thanks

parse : Url -> Maybe Route
parse url =
    Url.Parser.parse parser url

parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Form top
        -- , map Confilm (s "confilm")
        , map Thanks (s "thanks")
        ]