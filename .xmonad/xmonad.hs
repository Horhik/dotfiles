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
import XMonad.Hooks.DynamicLog
import XMonad.Util.Scratchpad
import XMonad.Util.NamedScratchpad

import qualified Graphics.X11.ExtraTypes.XF86 as XF86

import qualified XMonad.StackSet as W
import qualified Data.Map        as M


-- | Dracula Theme
backgroundColor    = "#282a36"
currentLineColor   = "#44475a"
selectionColor     = "#44475a"
foregroundColor    = "#f8f8f2"
commentColor       = "#6272a4"
cyanColor          = "#8be9fd"
greenColor         = "#50fa7b"
orangeColor        = "#ffb86c"
pinkColor          = "#ff79c6"
purpleColor        = "#bd93f9"
redColor           = "#ff5555"
yellowColor        = "#f1fa8c"


myTerminal            = "alacritty"
myEditor              = "nvim"
myFocusFollowsMouse   :: Bool
myFocusFollowsMouse   = True
myClickJustFocuses    :: Bool
myClickJustFocuses    = False
myBorderWidth         = 4
superKey              = mod4Mask
myModMask             = superKey
myWorkspaces          = ["home","web","code","test","tkr","task","edit", "chat","book"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = backgroundColor
myFocusedBorderColor = currentLineColor


------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

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
    -- change lang
    , ((modm              , xK_Alt_R ),  spawn "xkb-switch -n")
    -- toggle fullscreen
    , ((mod4Mask .|. shiftMask, xK_f), sendMessage ToggleStruts)
    -- dropdown terminal
    , ((modm                  , xK_u),  namedScratchpadAction myScratchpads "terminal")
    , ((modm .|. controlMask .|. shiftMask, xK_h), namedScratchpadAction myScratchpads "htop")

    -- | Programs
    , ((modm .|. shiftMask, xK_z), spawn "zathura &")                                                       -- book reader (zathura)
    , ((modm .|. shiftMask, xK_b), spawn "firefox-developer-editioin &"                           )         -- browser
    , ((modm .|. shiftMask, xK_b), spawn "firefox-developer-editioin &"                           )         -- browser
    , ((modm .|. shiftMask, xK_e), spawn "emacs &"                                                )         -- editor (emacs)
    , ((modm .|. shiftMask, xK_n), spawn "firefox-developer-edition https://www.notion.so/horhi &")         -- noteapp



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
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

     ++
     [ ((0, XF86.xF86XK_MonBrightnessUp), spawn "lux -a 5")
     , ((0, XF86.xF86XK_MonBrightnessDown), spawn "lux -s 5"
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
defaultGapSize = 5
defaultGaps = gaps [(U,defaultGapSize), (R,defaultGapSize), (D, defaultGapSize), (L, defaultGapSize)]
defaultSpaces = spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True
spacesAndGaps = defaultSpaces . defaultGaps

myLayout =   smartBorders . avoidStruts $ spacesAndGaps $ tiled ||| Mirror tiled ||| Full
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
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "TerminalDropdown"       --> doFloat
    , title =? "dropdown"       --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    ])
    <+> namedScratchpadManageHook myScratchpads

------------------------------------------------------------------------
-- | Scratchpads | -----------------------------------------------------

myScratchpads = [
  NS "terminal" spawnTerm findTerm manageTerm,
  NS "htop" "xterm -e htop" (title =? "htop") defaultFloating
    ]
  where
    classTerm     = "terminal-dropdown"
    titleTerm     = "!dropdown!"
    spawnTerm     = "alacritty  -t " ++ titleTerm
    findTerm      = title =? titleTerm
    manageTerm    = customFloating $ W.RationalRect l t w h
      where
        h = 0.6             -- height, 50%
        w = 0.6             -- width, 50%
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
myLogHook xmproc = dynamicLogWithPP $ xmobarPP { -- XMobar
            ppOutput     = hPutStrLn     xmproc
          , ppTitle      = xmobarColor   orangeColor     ""   . shorten 40
          , ppLayout     = xmobarColor   purpleColor     ""
          , ppCurrent    = xmobarColor   greenColor      ""   .  wrap "(" ")"
          , ppUrgent     = xmobarColor   redColor        ""   .  wrap "[" "]"
          , ppHidden     = xmobarColor   foregroundColor ""   .  noScratchPad
          , ppVisible    = xmobarColor   orangeColor     ""
          , ppSep        = xmobarColor   foregroundColor ""           "}-----{"
          , ppWsSep      =                                            "}-{"
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
  spawnOnce "variety &"
  -- spawnOnce "compton --config ~/.config/compton/compton.conf &"
  spawnOnce "picom &"
  spawnOnce "setxkbmap -layout us,ru"
  spawnOnce "$HOME/Scripts/startup/touchpad.sh"
  spawnOnce "sh ssh-agent bash ; ssh-add ~/.ssh/arch"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
  xmproc <- spawnPipe "xmobar -d ~/.config/xmobar/config.hs"
  xmonad $ docks $ defaults xmproc

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults xmproc = def {
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
        logHook            = myLogHook xmproc,
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
