Config {

   -- appearance
     font =         "xft:Mononoki-10:antialias=true"
   , additionalFonts = [
                         "xft:Fira Code-10:bold:antialias=true:hinting=True"
                       , "xft:Mononoki-10:bold:antialias=true:hinting=True"
                       ]
   , bgColor =      "#282a36"
   , fgColor =      "#f8f8f2"
   , position =     Top
   , border =       BottomB
   , borderColor =  "#282a36"
   , iconRoot = "."

   -- layout
   , sepChar =  "%"   -- delineator between plugin names and straight text
   , alignSep = "]["  -- separator between left-right alignment
   , template = "--{%StdinReader%}---------------------------------------------------------------------------------------------------------------------------------][{ %coretemp%}-{ %memory% }-{ %dynnetwork% }-{ %battery%}-{ %date% }-{ %kbd% }--"

   -- general behavior
   , lowerOnStart =     False    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest =     False   -- choose widest display (multi-monitor)
   , persistent =       False    -- enable/disable hiding (True = disabled)

   -- plugins
   --   Numbers can be automatically colored according to their value. xmobar
   --   decides color based on a three-tier/two-cutoff system, controlled by
   --   command options:
   --     --Low sets the low cutoff
   --     --High sets the high cutoff
   --
   --     --low sets the color below --Low cutoff
   --     --normal sets the color between --Low and --High cutoffs
   --     --High sets the color above --High cutoff
   --
   --   The --template option controls how the plugin is displayed. Text
   --   color can be set by enclosing in <fc></fc> tags. For more details
   --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
   , commands =

        -- weather monitor
        [ Run Weather "RJTT" [ "--template", "<skyCondition> | <fc=#4682B4><tempC></fc>°C | <fc=#4682B4><rh></fc>% | <fc=#4682B4><pressure></fc>hPa"
                             ] 36000

        -- network activity monitor (dynamic interface resolution)
        , Run DynNetwork     [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                             , "--Low"      , "1000"       -- units: B/s
                             , "--High"     , "5000"       -- units: B/s
                             , "--low"      , "#50fa7b"
                             , "--normal"   , "#ffb86c"
                             , "--high"     , "#ff5555"
                             ] 10

        -- cpu activity monitor
        , Run MultiCpu       [ "--template" , "Cpu: <total0>%|<total1>%"
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "#50fa7b"
                             , "--normal"   , "#ffb86c"
                             , "--high"     , "#ff5555"
                             ] 10

        -- cpu core temperature monitor
        , Run CoreTemp       [ "--template" , "Temp: <core0>°C|<core1>°C"
                             , "--Low"      , "70"        -- units: °C
                             , "--High"     , "80"        -- units: °C
                             , "--low"      , "#50fa7b"
                             , "--normal"   , "#ffb86c"
                             , "--high"     , "#ff5555"
                             ] 50

        -- memory usage monitor
        , Run Memory         [ "--template" ,"Mem: <usedratio>%"
                             , "--Low"      , "20"        -- units: %
                             , "--High"     , "90"        -- units: %
                             , "--low"      , "#50fa7b"
                             , "--normal"   , "#ffb86c"
                             , "--high"     , "#ff5555"
                             ] 10

        -- battery monitor
        , Run Battery        [ "--template" , "Batt: <acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "darkred"
                             , "--normal"   , "#ffb86c"
                             , "--high"     , "#50fa7b"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=#ffb86c>Charging</fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#50fa7b>Charged</fc>"
                             ] 50

        -- time and date indicator
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date           "<fc=#bd93f9>%F (%a) %T</fc>" "date" 10

        -- keyboard layout indicator
        , Run Kbd            [ ("us" , "<fc=#8be9fd>EN</fc>")
                             , ("ru"         , "<fc=#ff5555>RU</fc>")
                             ]
        , Run StdinReader
        , Run Brightness
              [ "-t", "<ipat>"
              , "--"
              , "--brightness-icon-pattern", "<icon=bright_%/home/horhik/Pictures/test.xpm%/>"
              ] 30
        ]
   }
