{-# LANGUAGE ScopedTypeVariables, TypeSynonymInstances, FlexibleInstances #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  TaskMonad
-- Copyright   :  Max magorsch <max@magorsch.de>
-- License     :  BSD-style (see LICENSE)
--
-- Maintainer  :  Max Magorsch <max@magorsch.de>
-- Stability   :  unstable
-- Portability :  unportable
--
-- TaskMonad bundles a number of tools that can be used to directly interact
-- with taskwarrior from within xmonad. Furthermore, workflows following the
-- Getting Things Done principles are implemented.
--
--
-----------------------------------------------------------------------------

module TaskMonad
  (
       -- * Installation

       -- ** Install with Cabal
       -- $installWithCabal

       -- ** Install without Cabal
       -- $installWithoutCabal
    
       -- * Usage
       -- $usage
    
       -- * Step 1: Capture
       -- $capture
    taskwarriorPrompt
  ,

       -- * Step 2 & 3: Clarify & Organize
       -- $organize
    processInbox
  ,

       -- * Step 4: Reflect
       -- $reflect
    togglePriority
  ,

       -- * Step 5: Engage
       -- $engage
    taskSelect
  , dueSelect
  , tagSelect
  , projectSelect
  ,

       -- * Scratchpad
       -- $scratchpad
    taskwarriorScratchpads
  , taskwarriorScratchpad

       -- * All Components
       -- $components
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

import           TaskMonad.Prompt
import           TaskMonad.ScratchPad
import           TaskMonad.Utils
import           TaskMonad.GridSelect




-- $installWithCabal
-- 
-- To install TaskMonad from hackage just execute:
-- 
-- > cabal update
-- > cabal install TaskMonad
-- 
-- Afterwards import TaskMonad in your `xmonad.hs`  
-- 
-- > import TaskMonad
-- 

-- $installWithoutCabal
-- 
-- To install Taskmonad without using cabal just download and copy the source code into your `~/.xmonad/-- lib/` folder. The folder structure should afterwards look like this:
-- 
-- 
-- > .xmonad 
-- > |-- lib
-- > |   |-- Taskmonad.hs
-- > |   |-- Taskmonad
-- > |   |   |-- GridSelect.hs
-- > |   |   |-- Prompt.hs
-- > |   |   |-- ScratchPad.hs
-- > |   |   `-- Utils.hs
-- > |   |-- GridSelect
-- > |   |   `-- Extras.hs
-- > |   `-- ...
-- > |-- xmonad.hs
-- 
-- 
-- Afterwards import TaskMonad in your `xmonad.hs`  
-- 
-- > import TaskMonad
-- 


-- $usage
-- To get started, add a manage hook for the taskwarrior scratchpad:
--
-- > import TaskMonad
-- > 
-- > -- ...
-- >
-- > ... , manageHook = namedScratchpadManageHook taskwarriorScratchpads
--
-- After that you can bind the taskwarrior prompt to a key to get started: 
--
-- > ... , ("M-p",     taskwarriorPrompt [(\x -> x == "processInbox", processInbox)])
--
-- You can also bind any other TaskMonad action to a key. For example:
--
-- > ... , ("M-S-p",   taskwarriorScratchpad)       -- Opens the taskwarrior scratchpad
-- >
-- > ... , ("M-C-p",   taskSelect "status:pending") -- Displays all pending tasks
-- >
-- > ... , ("M-C-S-p", tagSelect)                   -- Displays all tags
--
-- In general you can customize the tools ad libitum. A good way to get started is to implement custom actions for the taskwarrior prompt. Please refer to 'taskwarriorPrompt' for further information.  


-- $capture
--
-- You can easily capture tasks, ideas or notes using the 'taskwarriorPrompt' like this:
--
-- << https://raw.githubusercontent.com/mmagorsc/taskmonad/master/docs/images/capture.png >>
--

-- $organize
-- You can clarify and organize your tasks using 'processInbox'.
-- It implements the typical Getting Things Done workflow using GridSelects:
-- 
-- << https://raw.githubusercontent.com/mmagorsc/taskmonad/master/docs/images/workflow.png >>
--

-- $reflect
-- You can implement your own custom daily- and weeklyreview routines.
-- For example you can use 'togglePriority' to adjust the priority of tasks
-- during the daily- / weeklyreview like this:
--
-- << https://raw.githubusercontent.com/mmagorsc/taskmonad/master/docs/images/taskmonad-gridselect.png >>

-- $engage
-- To decide which task to do next, you can use a collection of gridselects.
-- You can use 'tagSelect', 'projectSelect', 'dueSelect' to display a gridselect
-- to filter the tasks by tag, project or due date. However you can also display
-- all pending tasks using 'taskSelect' like this:
--
-- << https://raw.githubusercontent.com/mmagorsc/taskmonad/master/docs/images/engage.png >>

-- $scratchpad
-- The taskwarrior scratchpad is used to display taskwarrior reports that
-- have been invoked using the taskwarrior prompt. However, you can use the
-- scratchpad at your convenience. Just add a manage hook:
--
-- > ... , manageHook = namedScratchpadManageHook taskwarriorScratchpads
--
-- Afterwards you can bind a key to 'taskwarriorScratchpad'. The Scratchpad will look like this
--
-- << https://raw.githubusercontent.com/mmagorsc/taskmonad/master/docs/images/taskmonad-scratchpad.png >>

-- $components
-- * 'TaskMonad'
--
--     * 'TaskMonad.Prompt'
--     * 'TaskMonad.Scratchpad'
--     * 'TaskMonad.GridSelect'
--     * 'TaskMonad.Utils'
--
-- * 'GridSelect.Extras'


-- | Opens a set of gridselects used to process the inbox using the Getting Things Done workflow
processInbox :: X ()
processInbox = io (getTaskwarriorTaskList "+INBOX" ["id", "description"])
  >>= \ts -> startInboxProcessing ts


-- | Recursively processes a given list of tasks using the typical GTD workflow. 
startInboxProcessing :: [[String]] -> X ()
startInboxProcessing []       = dummyAction
startInboxProcessing (t : ts) = twgs
  ("Actionable?  " ++ t !! 1, [("YES", actionable), ("NO", not_actionable)])
 where
  not_actionable = twgs
    ( "Next Steps: " ++ t !! 1
    , [ ("[Back]"         , startInboxProcessing (t : ts))
      , ("Reference"      , moveToFile t ts)
      , ("Project Support", moveToFile t ts)
      , ("Someday/Later"  , somedayLater t ts)
      , ("Trash"          , trash t ts)
      ]
    )

  actionable = twgs
    ( "Does it take multiple steps?"
    , [ ("[Back]", startInboxProcessing (t : ts))
      , ("YES"   , makeProject t ts)
      , ("NO"    , single_step)
      ]
    )

  single_step = twgs
    ( "Does it take less than 2 minutes?"
    , [("[Back]", actionable), ("YES", do_it), ("NO", more_than_2_min)]
    )

  do_it =
    twgs ("Do it now!", [("[Back]", single_step), ("Finished", done t ts)])

  more_than_2_min = twgs
    ( "Next Steps: " ++ t !! 1
    , [ ("[Back]"          , single_step)
      , ("Move to calendar", calendar t ts)
      , ("Waiting For"     , waitingFor t ts)
      , ("Edit Task"       , edit_task)
      ]
    )

  edit_task = twgs
    ( "How to process task: " ++ head t
    , [ ("[Back]"         , more_than_2_min)
      , ("[Finish]"       , startInboxProcessing ts)
      , ("Free Editing"   , editTaskAction t ts)
      , ("Set Tags"       , editTaskAction t ts)
      , ("Set Description", editTaskAction t ts)
      , ("Set Due Date"   , editTaskAction t ts)
      , ("Set Project"    , editTaskAction t ts)
      , ("Set Context"    , editTaskAction t ts)
      ]
    )


-- | Sends a message to the notification daemon 
notify :: MonadIO m => String -> m ()
notify message = unsafeSpawn $ "notify-send '" ++ message ++ "'"


-- | Opens a GridSelect with a custom message and the taskwarrior icon
twgs :: (String, [(String, X ())]) -> X ()
twgs (message, actions) = GridSelect.Extras.runSelectedActionWithMessageAndIcon
  defaultTWGSExtraConfig
  message
  twicon
  actions


-- | Deletes the current task. Afterwards the remaining tasks will be processed.
trash
  :: [String] -- ^ the current task
  -> [[String]] -- ^ the remaining tasks
  -> X ()
trash t ts = do
  runTmuxCommand $ "echo 'yes' | task " ++ head t ++ " delete"
  notify $ "Deleted Task:\n\n " ++ (t !! 1)
  startInboxProcessing ts


-- | Sets a task to done. Afterwards the remaining tasks will be processed.
done
  :: [String] -- ^ the current task
  -> [[String]] -- ^ the remaining tasks
  -> X ()
done t ts = do
  runTmuxCommand $ "echo 'yes' | task " ++ head t ++ " done"
  notify $ "Done Task:\n\n " ++ (t !! 1)
  startInboxProcessing ts


-- | Changes the tag of the current task from INBOX to SOMEDAY
-- Afterwards the task will be set as done and the remaining tasks will be processed.
somedayLater
  :: [String] -- ^ the current task
  -> [[String]] -- ^ the remaining tasks
  -> X ()
somedayLater t ts = do
  runTmuxCommand $ "task " ++ head t ++ " modify -INBOX +SOMEDAY"
  notify $ "Changed Task:\n\n " ++ (t !! 1) ++ "\n\n to Somday/Maybe"
  startInboxProcessing ts


-- | Changes the tag of the current task from INBOX to WAITINGFOR
-- Afterwards the remaining tasks will be processed.
waitingFor
  :: [String] -- ^ the current task
  -> [[String]] -- ^ the remaining tasks
  -> X ()
waitingFor t ts = do
  runTmuxCommand $ "task " ++ head t ++ " modify -INBOX +WAITINGFOR"
  notify $ "Changed Task:\n\n  " ++ (t !! 1) ++ "\n\n to Waiting For"
  startInboxProcessing ts


-- | Moves the information of the current task to a markdown file. 
-- Afterwards the task will be set as done and the remaining tasks will be processed.
moveToFile
  :: [String] -- ^ the current task
  -> [[String]] -- ^ the remaining tasks
  -> X ()
moveToFile t ts = do
  runTmuxCommand
    $  "task information "
    ++ head t
    ++ " >> ~/reference/inbox.md && echo 'yes' | task "
    ++ head t
    ++ " done"
  notify
    $ "Moved the task:\n\n "
    ++ (t !! 1)
    ++ "\n\n to the file: \n\n ~/reference/inbox.md.\n \n Please consider editing the file."
  startInboxProcessing ts


-- | Opens a customPrompt to create an appointment using
-- [gcalcli](https://github.com/insanum/gcalcli)
-- Afterwards the task will be set as done and the remaining tasks will be processed.
calendar
  :: [String] -- ^ the current task
  -> [[String]] -- ^ the remaining tasks
  -> X ()
calendar t ts = customPrompt "gcalcli add" [] (addAndContinue t ts)
 where
  addAndContinue t ts x = do
    runTmuxCommand ("gcalcli add --noprompt " ++ x)
    notify "Created Appointment."
    done t ts


-- | Opens a customPrompt to create a project for a given task
-- Afterwards the task will be set as done and the remaining tasks will be processed.
makeProject
  :: [String] -- ^ the current task
  -> [[String]] -- ^ the remaining tasks
  -> X ()
makeProject t ts = do
  notify ("Please create your first task for the project: \n\n " ++ t !! 1)
  customPrompt "task add" [] (addAndContinue t ts)
 where
  addAndContinue t ts x = do
    runTmuxCommand ("task add " ++ x)
    done t ts


-- | Opens a customPrompt in order to modify the current taskwarrior task.
-- Afterwards the remaining tasks will be processed.
editTaskAction
  :: [String] -- ^ the current task
  -> [[String]] -- ^ the remaining tasks
  -> X ()
editTaskAction t ts = do
  notify "Please edit your task."
  customPrompt ("task " ++ head t ++ " modify") [] (addAndContinue t ts)
 where
  addAndContinue t ts x = do
    runTmuxCommand ("task " ++ head t ++ " modify " ++ x)
    notify "Edited the task"
    startInboxProcessing ts


-- | A dummy action for testing purposes
dummyAction :: X ()
dummyAction = createTWwindow >>= deleteWindow
 where
  createTWwindow =
    createNewWindow (Rectangle 450 150 1000 60) Nothing "Test" True
