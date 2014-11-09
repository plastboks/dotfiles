import XMonad

main = xmonad $ defaultConfig
    { borderWidth           = 1
    , terminal              = "urxvtc"
    , normalBorderColor     = "#cccccc"
    , focusedBorderColor    = "#cd8b00" }
