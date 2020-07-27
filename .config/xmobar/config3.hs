Config {
    -- Position xmobar along the top, with a stalonetray in the top right.
    -- Add right padding to xmobar to ensure stalonetray and xmobar don't
    -- overlap. stalonetrayrc-single is configured for 12 icons, each 23px
    -- wide. 
    -- right_padding = num_icons * icon_size
    -- right_padding = 12 * 23 = 276
    -- Example: position = TopP 0 276
    position = Top
    font = "xft:Mononoki-10:antialias=true:with_utf8=true",
    bgColor = "#282a36",
    fgColor = "#f8f8f2",
    lowerOnStart = False,
    overrideRedirect = False,
    allDesktops = True,
    persistent = True,
    commands = [
        Run Weather "KPAO" ["-t","<tempF>F <skyCondition>","-L","64","-H","77","-n","#50fa7b","-h","#ff5555","-l","#8be9fd"] 36000,
        Run MultiCpu ["-t","Cpu:<total0><total1><total2><total3>","-L","30","-H","60","-h","#ff5555","-l","#50fa7b","-n","#f1fa8c","-w","3"] 1,
        Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","#ff5555","-l","#50fa7b","-n","#f1fa8c"] 10,
        Run Network "eth0" ["-t","Net: <rx>, <tx>","-H","200","-L","10","-h","#ff5555","-l","#50fa7b","-n","#f1fa8c"] 10,
        Run Date "%a %b %_d %l:%M" "date" 10,
        Run Com "getMasterVolume" [] "volumelevel" 10,
        Run Brightness
              [ "-t", "<ipat>"
              , "--"
              , "--brightness-icon-pattern", "<icon=bright_%%.xpm/>"
              ] 30
        Run StdinReader

    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %multicpu%   %memory%   %swap%  %eth0%   Vol: <fc=#b2b2ff>%volumelevel%</fc>   <fc=#FFFFCC>%date%</fc>"
}
