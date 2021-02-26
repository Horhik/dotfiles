Config {

   -- appearance
     font =         "xft:Mononoki-11:bold:antialias=true:hinting=true"
   , additionalFonts = [
                         "xft:Fira Code-10:bold:antialias=true:hinting=True"
                       , "xft:Mononoki-10:bold:antialias=true:hinting=True"
                       ]
   , bgColor =      "#282828"
   , fgColor =      "#ebdbb2"
   , position =     Top
   , border =       BottomB
   , borderColor =  "#282828"
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
        [ Run Weather "RJTT" [ "--template", "<skyCondition> | <fc=#458588><tempC></fc>°C | <fc=#458588><rh></fc>% | <fc=#458588><pressure></fc>hPa"
                             ] 36000

        -- network activity monitor (dynamic interface resolution)
        , Run DynNetwork     [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                             , "--Low"      , "1000"       -- units: B/s
                             , "--High"     , "5000"       -- units: B/s
                             , "--low"      , "#8ec07c"
                             , "--normal"   , "#fabd2f"
                             , "--high"     , "#fb4934"
                             ] 10

        -- cpu activity monitor
        , Run MultiCpu       [ "--template" , "Cpu: <total0>%|<total1>%"
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "#8ec07c"
                             , "--normal"   , "#fabd2f"
                             , "--high"     , "#fb4934"
                             ] 10

        -- cpu core temperature monitor
        , Run CoreTemp       [ "--template" , "Temp: <core0>°C|<core1>°C"
                             , "--Low"      , "70"        -- units: °C
                             , "--High"     , "80"        -- units: °C
                             , "--low"      , "#8ec07c"
                             , "--normal"   , "#fabd2f"
                             , "--high"     , "#fb4934"
                             ] 50

        -- memory usage monitor
        , Run Memory         [ "--template" ,"Mem: <usedratio>%"
                             , "--Low"      , "20"        -- units: %
                             , "--High"     , "90"        -- units: %
                             , "--low"      , "#8ec07c"
                             , "--normal"   , "#fabd2f"
                             , "--high"     , "#fb4934"
                             ] 10

        -- battery monitor
        , Run Battery        [ "--template" , "Batt: <acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "darkred"
                             , "--normal"   , "#fabd2f"
                             , "--high"     , "#8ec07c"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=#fabd2f>Charging</fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#8ec07c>Charged</fc>"
                             ] 50

        -- time and date indicator
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date           "<fc=#b16286>%F (%a) %T</fc>" "date" 10

        -- keyboard layout indicator
        , Run Kbd            [ ("us" , "<fc=#83a598>EN</fc>")
                             , ("ru"         , "<fc=#fb4934>RU</fc>")
                             ]
        , Run StdinReader
        , Run Brightness
              [ "-t", "<ipat>"
              , "--"
              , "--brightness-icon-pattern", "<icon=bright_%/home/horhik/Pictures/test.xpm%/>"
              ] 30
        ]
   }
