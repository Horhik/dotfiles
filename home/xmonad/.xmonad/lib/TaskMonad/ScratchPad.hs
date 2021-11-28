{-# LANGUAGE ScopedTypeVariables, TypeSynonymInstances, FlexibleInstances #-}

-----------------------------------------------------------------------------
-- |
-- Module      :  TaskMonad.ScratchPad
-- Copyright   :  Max Magorsch <max@magorsch.de>
-- License     :  BSD-style (see LICENSE)
--
-- Maintainer  :  Max Magorsch <max@magorsch.de>
-- Stability   :  unstable
-- Portability :  unportable
--
-- A wrapper around [XMonad.Util.NamedScratchpad]
-- (hackage.haskell.org/package/xmonad-contrib/docs/XMonad-Util-NamedScratchpad.html)
-- that can be used to display taskwarrior commands 
--
-----------------------------------------------------------------------------

module TaskMonad.ScratchPad
  (
       -- * Usage
       -- $usage

       -- * Screenshots
       -- $screenshots
    taskwarriorScratchpad
  , taskwarriorScratchpads
  , hideScratchpadAction
  , twscratchpad
  , runTmuxCommand
  )
where

import           Data.List
import           Data.Maybe
import           System.Process
import           System.IO
import           Control.Monad                  ( filterM )

import           XMonad                  hiding ( liftX )
import           XMonad.Util.Font
import qualified XMonad.StackSet               as W
import           XMonad.Layout.Decoration
import           XMonad.Prompt
import           XMonad.Prompt.Input
import           XMonad.Util.Image
import           XMonad.Util.NamedWindows
import           XMonad.Util.XUtils
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run
import           XMonad.Actions.GridSelect

import qualified GridSelect.Extras

-- $usage
--
-- Just add a manage hook:
--
-- > , manageHook = namedScratchpadManageHook taskwarriorScratchpads
--



-- $screenshots
--
-- TaskMonad.Scratchpad in action:
--
-- <<https://raw.githubusercontent.com/mmagorsc/taskmonad/master/docs/images/taskmonad-scratchpad.png>>


-- | Open the TaskWarrior-ScratchPad
taskwarriorScratchpad :: X ()
taskwarriorScratchpad =
  namedScratchpadAction taskwarriorScratchpads "taskwarrior"

-- | The TaskWarrior-Scratchpad which contains a tmux session
taskwarriorScratchpads :: [NamedScratchpad]
taskwarriorScratchpads =
  [NS "taskwarrior" spawnTaskwarrior findTerm manageTerm] -- and a second ]
 where
  spawnTaskwarrior =
    "alacritty" ++ " -t scratchpad" ++ " -e tmux new -A -s tw-scratch"
  findTerm   = appName =? "scratchpad" -- its window will be named "scratchpad" (see above)
  manageTerm = customFloating $ W.RationalRect 0.25 0 0.5 0.6 -- l t w h


-- | Finds named scratchpad configuration by name
findByName :: NamedScratchpads -> String -> Maybe NamedScratchpad
findByName c s = listToMaybe $ filter ((s ==) . name) c


-- | Runs application which should appear in specified scratchpad
runApplication :: NamedScratchpad -> X ()
runApplication = spawn . cmd


-- | Modified version of XMonad.Util.NamedScratchpad.hideScratchpadAction
-- which can be used to just show a scratchpad and don't hide it
-- in case it is already shown
hideScratchpadAction
  :: NamedScratchpads -- ^ Named scratchpads configuration
  -> String           -- ^ Scratchpad name
  -> X ()
hideScratchpadAction confs n
  | Just conf <- findByName confs n = withWindowSet $ \s -> do
        -- try to find it on the current workspace
    filterCurrent <- filterM
      (runQuery (query conf))
      ((maybe [] W.integrate . W.stack . W.workspace . W.current) s)
    case filterCurrent of
--            {- The following part is commented out, as it would hide the scratchpad -}                
--            (x:_) -> do
--                -- create hidden workspace if it doesn't exist
--                if null (filter ((== scratchpadWorkspaceTag) . W.tag) (W.workspaces s))
--                    then addHiddenWorkspace scratchpadWorkspaceTag
--                    else return ()
--                -- push window there
--                windows $ W.shiftWin scratchpadWorkspaceTag x
      [] -> do
          -- try to find it on all workspaces
        filterAll <- filterM (runQuery (query conf)) (W.allWindows s)
        case filterAll of
          (x : _) -> windows $ W.shiftWin (W.currentTag s) x
          []      -> runApplication conf
  | otherwise = return ()


-- | Send a taskwarrior command to the taskwarrior tmux session and open the taskwarrior scratchpad
twscratchpad :: String -> X ()
twscratchpad command =
  runTmuxCommand ("clear && task " ++ command)
    >> hideScratchpadAction taskwarriorScratchpads "taskwarrior"


-- | Send a command to the taskwarrior tmux session
runTmuxCommand :: MonadIO m => String -> m ()
runTmuxCommand command =
  unsafeSpawn $ "tmux send-keys -t tw-scratch.0 '" ++ command ++ "' ENTER"
