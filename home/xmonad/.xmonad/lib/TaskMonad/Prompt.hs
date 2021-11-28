{-# LANGUAGE ScopedTypeVariables, TypeSynonymInstances, FlexibleInstances #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  TaskMonad.Prompt
-- Copyright   :  Max Magorsch <max@magorsch.de>
-- License     :  BSD-style (see LICENSE)
--
-- Maintainer  :  Max Magorsch <max@magorsch.de>
-- Stability   :  unstable
-- Portability :  unportable
--
-- TaskMonad.Prompt provides wrappers around [XMonad.Prompt.Input]
-- (https://hackage.haskell.org/package/xmonad-contrib/docs/XMonad-Prompt-Input.html)
-- for usage with taskwarrior
--
-----------------------------------------------------------------------------

module TaskMonad.Prompt
  ( taskwarriorPrompt
  ,
       -- * Screenshots
       -- $screenshots
    customPrompt
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

import qualified GridSelect.Extras

import           TaskMonad.ScratchPad
import           TaskMonad.Utils
import           TaskMonad.GridSelect           ( togglePriority
                                                , defaultTWGSExtraConfig
                                                )


-- $screenshots
--
-- TaskMonad.Prompt in action:
--
-- <<https://raw.githubusercontent.com/mmagorsc/taskmonad/master/docs/images/taskmonad-prompt.png>>


-- | A wrapper around [XMonad.Prompt.Input]
-- (https://hackage.haskell.org/package/xmonad-contrib/docs/XMonad-Prompt-Input.html)
-- using a custom 'XPconfig'
customPrompt
  :: String -- ^ title that will be displayed in the prompt 
  -> [String] -- ^ completion list 
  -> (String -> X ()) -- ^ action that takes the input of the prompt and returns and X ()
  -> X () -- ^ the action that shows the prompt
customPrompt name completeList action =
  inputPromptWithCompl myXPConfig name (mkComplFunFromList completeList)
    ?+ action
 where
  myXPConfig = def { position          = CenteredAt 0.5 0.4
                   , alwaysHighlight   = True
                   , height            = 60
                   , promptBorderWidth = 1
                   , font              = "xft:Inconsolata:size=14"
                   , borderColor       = "#555555"
                   , bgColor           = "#111111"
                   }


-- | A wrapper around 'customPrompt' that can be used to execute taskwarrior
-- as well as custom commands.
--
-- You can specify a list of tuples which contain
-- custom actions as well as conditions for the custom actions, like this:
--
-- > taskwarriorPrompt [(\x -> x == "processInput", processInput)]
--
-- However, if none of the specified actions is true, a default action will be executed.
-- The default action shows taskwarrior reports in a scratchpad and executes all the other commands silently.  
taskwarriorPrompt
  :: [(String -> Bool, X ())] -- ^ a list of tuples which contain a condition for an action as well as the action
  -> X () -- ^ the resulting TaskWarrior prompt
taskwarriorPrompt possibleActions =
  customPrompt "task" defaulttwreports (possiblePromptAction possibleActions)


-- | Recursively goes through a list of conditional actions. If a condition is fulfilled, the
-- related action will be executed, otherwise the next condition in the list will be evaluated.
-- In case no condition is fulfilled the 'defaultTWPromptAction' will finally be executed.
possiblePromptAction [] command = defaultTWPromptAction command
possiblePromptAction (p : ps) command =
  if fst p command then snd p else possiblePromptAction ps command


-- | The default action that will be execute in the 'taskwarriorPrompt', if no other action was executed.
defaultTWPromptAction :: String -> X ()
defaultTWPromptAction command = if isTWReport command
  then twscratchpad command
  else twcommand command
 where
  twcommand command = io (execCommandWithOutput "task" command)
    >>= \bs -> unsafeSpawn $ "notify-send '" ++ bs ++ "'"

