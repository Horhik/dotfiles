{-# LANGUAGE ScopedTypeVariables, TypeSynonymInstances, FlexibleInstances #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  TaskMonad.GridSelect
-- Copyright   :  Max Magorsch <max@magorsch.de>
-- License     :  BSD-style (see LICENSE)
--
-- Maintainer  :  Max Magorsch <max@magorsch.de>
-- Stability   :  unstable
-- Portability :  unportable
--
-- TaskMonad.GridSelect uses 'GridSelect.Extras' to display various information from taskwarrior. 
--
-----------------------------------------------------------------------------

module TaskMonad.GridSelect
  (
       -- * Screenshot
       -- $screenshots
       -- 

       -- * Possible GridSelects
    taskSelect
  , taskSelectWithConfig
  , tagSelect
  , tagSelectWithConfig
  , projectSelect
  , projectSelectWithConfig
  , dueSelect
  , dueSelectWithConfig
  , togglePriority
  , togglePriorityWithConfig
  ,

       -- * Configuration
    buildTWGSExtraConfig
  , buildTWGSConfig
  , defaultTWGSConfig
  , defaultTWGSExtraConfig
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

import           TaskMonad.Utils
import           TaskMonad.ScratchPad

-- $screenshots
-- 'togglePriority' in action:
-- 
-- << https://raw.githubusercontent.com/mmagorsc/taskmonad/master/docs/images/taskmonad-gridselect.png >>


-- | A GridSelect displaying a filtered list of all taskwarrior tasks
taskSelectWithConfig
  :: String -- ^ a filter to be applied, please refer to [TaskWarrior Filter](https://taskwarrior.org/docs/filter.html) for further information
  -> GSConfig (X ()) -- ^ the GridSelect config to be used
  -> X () -- ^ the gridselect displaying all filtered tasks
taskSelectWithConfig filter gsConfig =
  io (getTaskwarriorTaskList filter ["id", "description"]) >>= \bs -> case bs of
    [] -> safeSpawn "firefox" []
    _  -> runSelectedAction gsConfig . finishGS $ fmap openBuffer bs
 where
  finishGS = (("[Finish]", unsafeSpawn "") :)
  openBuffer x = (x !! 1, twscratchpad (head x ++ " information"))


-- | A wrapper around 'taskSelectWithConfig' using the default GSConfig
taskSelect
  :: String -- ^ a filter to be applied, please refer to [TaskWarrior Filter](https://taskwarrior.org/docs/filter.html) for further information
  -> X () -- ^ the gridselect displaying all filtered tasks
taskSelect filter = taskSelectWithConfig filter (buildTWGSConfig 300)


-- | A GridSelect displaying a list of the tags of all pending taskwarrior tasks. After a tag has been selected, a second gridselect showing a filtered list of taskwarrior tasks that have the selected tag will be displayed. 
tagSelectWithConfig
  :: (GSConfig (X ()), GSConfig (X ())) -- ^ A tuple containing two GSConfigs. The first one is used to configure the gridselect displaying the list of tags. The second one is used to configure the gridselect displaying the resulting fitlered list of tasks. 
  -> X () -- ^ a gridSelect displaying a list of the tags of all pending taskwarrior tasks
tagSelectWithConfig (fstGsConfig, sndGsConfig) =
  io (getTaskwarriorIds "status:pending" "tags") >>= \bs -> case bs of
    [] -> safeSpawn "firefox" []
    _  -> runSelectedAction fstGsConfig . finishGS $ fmap openBuffer
                                                          (filteredTags bs)
 where
  finishGS = (("[Finish]", unsafeSpawn "") :)
  openBuffer x = (x, taskSelectWithConfig ("+" ++ x) sndGsConfig)
  filteredTags bs = [ x | x <- bs, x `notElem` hiddenTags ]
  hiddenTags =
    [ "BLOCKED"
    , "UNBLOCKED"
    , "UNBLOCKED"
    , "DUE"
    , "DUETODAY"
    , "TODAY"
    , "OVERDUE"
    , "WEEK"
    , "MONTH"
    , "QUARTER"
    , "YEAR"
    , "ACTIVE"
    , "SCHEDULED"
    , "PARENT"
    , "CHILD"
    , "UNTIL"
    , "WAITING"
    , "ANNOTATED"
    , "READY"
    , "YESTERDAY"
    , "TOMORROW"
    , "TAGGED"
    , "PENDING"
    , "COMPLETED"
    , "DELETED"
    , "UDA"
    , "ORPHAN"
    , "PRIORITY"
    , "PROJECT"
    , "LATEST"
    , "nocal"
    , "nonag"
    , "nocolor"
    ]


-- | A wrapper around 'tagSelectWithConfig' using the default GSConfig
tagSelect :: X ()
tagSelect = tagSelectWithConfig (defaultTWGSConfig, buildTWGSConfig 300)


-- | A GridSelect displaying a list of all pending projects. After a project has been selected, a second gridselect showing a filtered list of taskwarrior tasks that belong to the selected project  will be displayed.
projectSelectWithConfig
  :: (GSConfig (X ()), GSConfig (X ())) -- ^ A tuple containing two GSConfigs. The first one is used to configure the gridselect displaying the list of pending projects. The second one is used to configure the gridselect displaying the resulting filtered list of tasks. 
  -> X () -- ^ a GridSelect displaying a list of all pending projects
projectSelectWithConfig (fstGsConfig, sndGsConfig) =
  io (getTaskwarriorIds "status:pending" "projects") >>= \bs -> case bs of
    [] -> safeSpawn "firefox" []
    _  -> runSelectedAction fstGsConfig . finishGS $ fmap openBuffer bs
 where
  finishGS = (("[Finish]", unsafeSpawn "") :)
  openBuffer x = (x, taskSelectWithConfig ("project:" ++ x) sndGsConfig)


-- | A wrapper around 'projectSelectWithConfig' using the default GSConfig
projectSelect :: X ()
projectSelect =
  projectSelectWithConfig (defaultTWGSConfig, buildTWGSConfig 300)


-- | A GridSelect displaying a list of due dates. After a due date has been selected, a second gridselect showing a filtered list of taskwarrior tasks will be displayed.
dueSelectWithConfig
  :: (GSConfig (X ()), GSConfig (X ()))  -- ^ A tuple containing two GSConfigs. The first one is used to configure the gridselect displaying the list of due dates. The second one is used to configure the gridselect displaying the resulting filtered list of tasks.
  -> X () -- ^ a GridSelect displaying a list of all due dates
dueSelectWithConfig (fstGsConfig, sndGsConfig) = runSelectedAction
  fstGsConfig
  actions
 where
  actions =
    [ ("overdue" , taskSelectWithConfig "+OVERDUE" sndGsConfig)
    , ("today"   , taskSelectWithConfig "+TODAY" sndGsConfig)
    , ("tomorrow", taskSelectWithConfig "+TOMORROW" sndGsConfig)
    , ("week"    , taskSelectWithConfig "+WEEK" sndGsConfig)
    , ("month"   , taskSelectWithConfig "+MONTH" sndGsConfig)
    , ("year"    , taskSelectWithConfig "+YEAR" sndGsConfig)
    ]


-- | A wrapper around 'dueSelectWithConfig' using the default GSConfig
dueSelect :: X ()
dueSelect = dueSelectWithConfig (defaultTWGSConfig, buildTWGSConfig 300)


-- | A wrapper around 'togglePriorityWithConfig' using the default GridSelect.Extras.GSConfig
togglePriority
  :: String -- ^ the priority that should be toggled
  -> X () -- ^ the resulting gridselect
togglePriority = togglePriorityWithConfig (buildTWGSExtraConfig 300)


-- | A gridselect showing all pending tasks. The tasks are colored according to their priority. Selecting a task toggles its priority. 
togglePriorityWithConfig
  :: GridSelect.Extras.GSConfig (X ()) -- ^ a GridSelect.Extras.GSConfig used for the gridselect
  -> String -- ^ the priority that should be toggled
  -> X () -- ^ the resulting gridselect
togglePriorityWithConfig gsConfig priority =
  io (getTaskwarriorTaskList "+INBOX" ["id", "description", "priority"])
    >>= \bs -> case bs of
          [] -> safeSpawn "firefox" []
          _ ->
            GridSelect.Extras.runSelectedActionWithMessageAndIcon
                gsConfig
                ("Select " ++ priority ++ "s")
                twicon
              . startEmacs
              $ fmap (openBuffer priority) bs
 where
  startEmacs = (("[Finish]", safeSpawn "task" []) :)
  openBuffer priority x =
    ( if x !! 2 /= "" then x !! 2 ++ ": " ++ x !! 1 else x !! 1
    , toggleP priority x
    )
  toggleP priority x = if x !! 2 == priority
    then unsafeSpawn ("task " ++ head x ++ " modify priority:")
      >> togglePriority priority
    else unsafeSpawn ("task " ++ head x ++ " modify priority:" ++ priority)
      >> togglePriority priority


-- | Method used to build a GridSelect.Extra.GSConfig by specifying a custom cellwidth
buildTWGSExtraConfig
  :: Integer -- ^ the cellwidth
  -> GridSelect.Extras.GSConfig (X ()) -- ^ the resulting GridSelect.Extra.GSConfig
buildTWGSExtraConfig cellwidth = GridSelect.Extras.def
  { GridSelect.Extras.gs_cellheight   = 50
  , GridSelect.Extras.gs_cellwidth    = cellwidth
  , GridSelect.Extras.gs_cellpadding  = 10
  , GridSelect.Extras.gs_font = "xft:Liberation Mono:size=9:antialias=true"
  , GridSelect.Extras.gs_navigate     = GridSelect.Extras.defaultNavigation
  , GridSelect.Extras.gs_originFractX = 1 / 2
  , GridSelect.Extras.gs_originFractY = 1 / 2
  }


-- | Method used to build a GSConfig by specifying a custom cellwidth 
buildTWGSConfig
  :: Integer -- ^ the cellwidth
  -> GSConfig (X ()) -- ^  the resulting GSConfig
buildTWGSConfig cellwidth = (buildDefaultGSConfig myColorizer)
  { gs_cellheight   = 50
  , gs_cellwidth    = cellwidth
  , gs_cellpadding  = 10
  , gs_font         = "xft:Liberation Mono:size=9:antialias=true"
  , gs_navigate     = defaultNavigation
  , gs_originFractX = 1 / 2
  , gs_originFractY = 1 / 2
  }
 where
  myColorizer :: a -> Bool -> X (String, String)
  myColorizer _ p | p         = pure ("#f44336", "#1a1a1a")
                  | otherwise = pure ("#1a1a1a", "gray")


-- | The default GridSelect.Extra.GSConfig used for taskwarrior GridSelects
defaultTWGSExtraConfig :: GridSelect.Extras.GSConfig (X ())
defaultTWGSExtraConfig = buildTWGSExtraConfig 130


-- | The default GSConfig used for taskwarrior GridSelects
defaultTWGSConfig :: GSConfig (X ())
defaultTWGSConfig = buildTWGSConfig 130


