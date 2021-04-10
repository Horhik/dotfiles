-- | ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- | ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- | ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- | ░░░░░░░░░░░░░░░░░░░░░█░█░█▀█░█▀▄░█░█░▀█▀░█░█░▀░█▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- | ░░░░░░░░░░░░░░░░░░░░░█▀█░█░█░█▀▄░█▀█░░█░░█▀▄░░░▀▀█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- | ░░░░░░░░░░░░░░░░░░░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░░░▀▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- | ░░░░░░░░░░░░░░░░░░░░░█▀▄░█▀█░▀█▀░█▀▀░▀█▀░█░░░█▀▀░█▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- | ░░░░░░░░░░░░░░░░░░░░░█░█░█░█░░█░░█▀▀░░█░░█░░░█▀▀░▀▀█░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- | ░░░░░░░░░░░░░░░░░░░░░▀▀░░▀▀▀░░▀░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- | ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- | ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- | ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

import XMonad
import Data.Monoid
import System.Exit
import XMonad.Config.Desktop
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Gaps
import XMonad.Util.EZConfig
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Hooks.DynamicLog
import XMonad.Util.Scratchpad
import XMonad.Util.NamedScratchpad

import qualified Graphics.X11.ExtraTypes.XF86 as XF86

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import GruvboxColors as Colors 


home                  = "/home/horhik/"
myTerminal            = "alacritty"
myEditor              = "nvim"
myMainDisplay         = "eDP-1"
mySecondDisplay       = "HDMI-1"
myDmenuFont           = "Mononoki Nerd Font:size=16"
myFocusFollowsMouse   :: Bool
myFocusFollowsMouse   = True
myClickJustFocuses    :: Bool
myClickJustFocuses    = False
myBorderWidth         = 3
superKey              = mod4Mask
myModMask             = superKey
-- myWorkspaces          = ["home 1","web 2","code 3","test 4","tkr 5","task 6","edit 7", "chat 8","book 9"]
myWorkspaces          = ["I","II","III","IV","V","VI","VII", "VIII","IX"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = backgroundColor
myFocusedBorderColor = grayColor


------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
--    , ((modm,               xK_p     ), spawn ("dmenu_run " ++ " -fn '" ++ myDmenuFont ++ "' -nb '" ++  backgroundColor ++  "' -nf '" ++ selectionColor ++ "' -sb '"++ selectionColor ++"' -sf '"++foregroundSecondColor++"' -shb '"++ greenDarkerColor ++ "' -c "++" -l "++" 20 "))
    -- launch emoji picker
    , ((modm              , xK_e     ), spawn "emoji-menu")
    , ((modm              , xK_p     ), spawn "rofi -show drun")

    , ((modm .|. shiftMask , xK_p     ), spawn "rofi -show window")
  
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Gaps
    , ((modm .|. controlMask, xK_g), sendMessage $ ToggleGaps)

    , ((modm .|. controlMask, xK_o), sendMessage $ DecGap 10 L)
    , ((modm .|. controlMask, xK_u), sendMessage $ DecGap 10 U)
    , ((modm .|. controlMask, xK_i), sendMessage $ DecGap 10 D)
    , ((modm .|. controlMask, xK_y), sendMessage $ DecGap 10 R)

    , ((modm .|. shiftMask, xK_o), sendMessage $ IncGap 10 L)
    , ((modm .|. shiftMask, xK_u), sendMessage $ IncGap 10 U)
    , ((modm .|. shiftMask, xK_i), sendMessage $ IncGap 10 D)
    , ((modm .|. shiftMask, xK_y), sendMessage $ IncGap 10 R)

    -- flameshot gui
    , ((modm .|. shiftMask, xK_s ),  spawn "flameshot gui")
    , ((modm .|. mod1Mask         , xK_space ),  spawn "$HOME/.local/scripts/deadd_notify")
    -- change lang
    , ((modm, xK_Control_R)       , spawn "xkblayout-state set +1")
    , ((modm, xK_d)               , spawn "eww-toggl")
    -- toggle fullscreen
    , ((mod4Mask .|. shiftMask, xK_f), sendMessage ToggleStruts)

    -- | Scratchpads/Dropdowns
    , ((modm                  , xK_u),  namedScratchpadAction myScratchpads "terminal")
    , ((modm .|. controlMask .|. shiftMask, xK_h), namedScratchpadAction myScratchpads "htop")
    , ((modm .|. shiftMask    , xK_a),  namedScratchpadAction myScratchpads "anki")
    , ((modm .|. shiftMask    , xK_m),  namedScratchpadAction myScratchpads "pulse")
    , ((modm .|. shiftMask    , xK_n),  namedScratchpadAction myScratchpads "notion")
    , ((modm .|. shiftMask    , xK_d),  namedScratchpadAction myScratchpads "todoist")

    -- | Programs
    , ((modm .|. shiftMask, xK_z), spawn "zathura &")                                                                            -- book reader (zathura)
    , ((modm .|. shiftMask, xK_b), spawn "firefox"                                       )                                       -- browser
    , ((modm .|. controlMask, xK_e), spawn "/usr/bin/emacs &"                                                           )        -- editor (emacs)



    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_comma, xK_period, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

     ++
     [ ((0, XF86.xF86XK_MonBrightnessUp), spawn "light -A 5")
     , ((0, XF86.xF86XK_MonBrightnessDown), spawn "light -U 5"
     )]



------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
defaultGapSize = 10
defaultGaps = gaps [(U,defaultGapSize), (R,defaultGapSize), (D, defaultGapSize), (L, defaultGapSize)]
defaultSpaces = spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True
spacesAndGaps = defaultSpaces . defaultGaps

myLayout =   smartBorders . avoidStruts $ spacesAndGaps $ tiled ||| Mirror tiled ||| Full ||| simpleTabbed 
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = (composeAll
    [ className =? "MPlayer"                --> doFloat
    , className =? "Gimp"                   --> doFloat
    , title     =? "Media viewer"           --> doFloat -- Telegram image viewer
    , className =? "TerminalDropdown"       --> doFloat
    , className =? "Nemo"                   --> doCenter
    , title     =? "dropdown"               --> doFloat
    , resource  =? "desktop_window"         --> doIgnore
    , resource  =? "kdesktop"               --> doIgnore
    ])
    <+> namedScratchpadManageHook myScratchpads
  where
    doCenter    = customFloating $ W.RationalRect l t w h
      where
        h = 0.6             -- height, 50%
        w = 0.6             -- width, 50%
        t = (1 - h) / 2     -- bottom edge
        l = (1 - w) / 2     -- centered left/right

------------------------------------------------------------------------
-- | Scratchpads | -----------------------------------------------------

myScratchpads = [
    NS "terminal" spawnTerm findTerm manageTerm
  , NS "htop" "alacritty -t htop -e htop " (title =? "htop") defaultFloating
  , NS "pomo" "pomodone" (title =? "PomoDoneApp") defaultFloating
  , NS "notion" "notion" (title =? "Notion") defaultFloating
  , NS "anki" spawnAnki findAnki manageAnki
  , NS "pulse" spawnPulse findPulse managePulse
  , NS "todoist" spawnTodoist findTodoist manageTodoist
    ]
  where
    classTerm     = "TerminalDropdown"
    titleTerm     = "!dropdown!"
    spawnTerm     = "alacritty  -t " ++ titleTerm ++ " --class " ++ classTerm
    findTerm      = title =? titleTerm
    manageTerm    = customFloating $ W.RationalRect l t w h
      where
        h = 0.6             -- height, 50%
        w = 0.6             -- width, 50%
        t = (1 - h) / 2     -- bottom edge
        l = (1 - w) / 2     -- centered left/right
    titleAnki     = "Anki"
    spawnAnki     = "anki"
    findAnki      = className =? titleAnki
    manageAnki    = customFloating $ W.RationalRect l t w h
      where
        h = 0.9             -- height, 90%
        w = 0.4             -- width, 40%
        t = (1 - h) / 2     -- center
        l = 0.1
    classPulse     = "PulseDropdown"
    titlePulse     = "pulsemixer"
    spawnPulse     = "alacritty  -t " ++ titlePulse ++ " --class " ++ classPulse ++ " -e pulsemixer "
    findPulse      = title =? titlePulse
    managePulse    = customFloating $ W.RationalRect l t w h
      where
        h = 0.6             -- height, 50%
        w = 0.6             -- width, 50%
        t = (1 - h) / 2     -- bottom edge
        l = (1 - w) / 2     -- centered left/right

    classTodoist     = "TodoistDropdown"
    titleTodoist     = "Todoist"
    spawnTodoist     = "todoist"
    findTodoist      = title =? titleTodoist
    manageTodoist    = customFloating $ W.RationalRect l t w h
      where
        h = 0.7             -- height, 50%
        w = 0.4             -- width, 50%
        t = (1 - h) / 2     -- bottom edge
        l = (1 - w) / 2     -- centered left/right




------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--




myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--

xbb = backgroundColor -- xmobar background color
myLogHook (xmproc0, xmproc1) = dynamicLogWithPP $ xmobarPP { -- XMobar
            ppOutput     = \x ->             hPutStrLn xmproc0 x
                                         >> hPutStrLn xmproc1 x
          , ppTitle      = xmobarColor   orangeColor     ""   . shorten 40
          , ppLayout     = xmobarColor   purpleColor     ""
          , ppCurrent    = xmobarColor   greenColor      ""   .  wrap "(" ")"
          , ppUrgent     = xmobarColor   redColor        ""   .  wrap "[" "]"
          , ppHidden     = xmobarColor   foregroundColor ""   .  noScratchPad
          , ppVisible    = xmobarColor   orangeColor     ""   .  wrap "(" ")"
          , ppSep        = xmobarColor   cyanColor ""           "}—————{"
          , ppWsSep      = xmobarColor   cyanColor ""                 "}—{"
          , ppOrder      = \(ws:l:t:ex)  -> [ws]++ex++[t,l] -- {workspaces}-{title}--{layout}
      }

      where
        noScratchPad ws = if ws == "NSP" then "" else ws

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawnOnce "nitrogen --restore &"
  -- spawnOnce "compton --config ~/.config/compton/compton.conf &"
  spawnOnce "picom --experimental-backends &"
  spawnOnce "deadd-notification-center &"
  spawnOnce "setxkbmap us,ru &"
  spawnOnce "eww daemon"
  spawnOnce "nextcloud"
  spawnOnce "sh ssh-agent bash ; ssh-add ~/.ssh/arch"
  spawnOnce "eval '$(ssh-agent -s)'; ssh-add ~/.ssh/id_rsa"
  spawnOnce ("enact --pos left --watch &")
  spawnOnce ("xrandr --output HDMI1 --left-of eDP1&")
  spawnOnce (home ++ ".local/scripts/status/launch &")
  spawnOnce (home ++ ".local/scripts/touchpad.sh &")
  -- spawnOnce ("cd /home/horhik/Freenet/downloads/fms; ./fms --daemon &")
  spawnOnce "xautolock -time 25 -locker i3lock-fancy-multimonitor -notifier 'xkb-switch -s us' &"
  spawnOnce "eval '$(ssh-agent -s)'; ssh-add ~/.ssh/id_rsa &"
  spawnOnce "sleep 10; pulseaudio -k"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
  bar0 <- spawnPipe "xmobar -x 0 -d ~/.config/xmobar/config.hs"
  bar1 <- spawnPipe "xmobar -x 1 ~/.config/xmobar/config_second.hs"
  xmonad $ docks $ defaults (bar0, bar1)

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults (bar0, bar1) = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook (bar0, bar1),
        startupHook        = myStartupHook
    }

-- | Brightness

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
