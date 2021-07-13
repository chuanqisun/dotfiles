-- IMPORT
import XMonad
import Data.Monoid
import System.Exit

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))

import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Renamed
import XMonad.Layout.NoBorders

import XMonad.Actions.WorkspaceNames
import XMonad.Actions.GroupNavigation
import XMonad.Actions.CycleWS
import XMonad.Actions.SwapPromote

import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (mkKeymap)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Global variables
myTerminal      = "alacritty"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False
myClickJustFocuses :: Bool
myClickJustFocuses = False
myBorderWidth   = 5
myModMask       = mod1Mask
myWorkspaces    = ["1","2","3"]
myNormalBorderColor  = "#504945" -- gruvbox bg2
myFocusedBorderColor = "#fe8019" -- gruvbox organge


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button2, Set the window to floating mode and move by dragging
    [ ((modm, button2), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button3, Raise the window to the top of the stack
    , ((modm, button3), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button1, Set the window to floating mode and resize by dragging
    , ((modm, button1), (\w -> focus w >> mouseResizeWindow w
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

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True


-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts $ smartBorders $ (tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled = renamed [Replace "master/stack"]
             $ mySpacing 5 
	     $ ResizableTall 1 (3/100) (1/2) []

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
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
		, isFullscreen --> doFullFloat]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = dynamicLogWithPP

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    xmproc <- spawnPipe "xmobar /home/cs/.config/xmobar/.xmobarrc"
    xmonad $ docks def {
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
        keys               = \c -> mkKeymap c $
	[ ("M-S-<Return>", spawn $ XMonad.terminal c) -- Open terminal
	, ("M-<Return>", spawn "rofi -combi-modi drun,run -show combi -run-shell-command 'alacritty -e zsh -c \"{cmd} && zsh\"'") -- Rofi run app
	, ("M-q", kill) -- Kill current window
	, ("M-S-q", io (exitWith ExitSuccess)) -- Quite XMonad
	, ("M-r", spawn "xmonad --recompile; xmonad --restart") -- Restart Xmonad

	, ("M-f", sendMessage NextLayout) -- Apply next layout (effective toggle full screen mode)

	, ("M-l", moveTo Next NonEmptyWS) -- move to next workspace
	, ("M-S-l", shiftToNext >> nextWS) -- follow to next workspace
	, ("M-h", moveTo Prev NonEmptyWS) -- move to prev workspace
	, ("M-S-h", shiftToPrev >> prevWS) -- follow to prev workspace

	, ("M-t", withFocused $ windows . W.sink) -- Push selected to tiling

        , ("M-m", swapHybrid' False)  -- Swap the focused window and the master window
	, ("M-j", windows W.focusDown) -- focus next window
	, ("M-<Tab>", nextMatch Forward isOnAnyVisibleWS) -- focus next window
	, ("M-S-j", windows W.swapDown) -- swap with next window
	, ("M-k", windows W.focusUp) -- focus prev window
	, ("M-S-<Tab>", nextMatch Backward isOnAnyVisibleWS) -- focus prev window
	, ("M-S-k", windows W.swapUp) -- swap with prev window

	, ("M-<Left>", sendMessage Shrink) -- horizontal shrink
	, ("M-<Right>", sendMessage Expand) -- horizontal expand
	, ("M-<Down>)", sendMessage MirrorShrink) -- virtal shrink
	, ("M-<Up>)", sendMessage MirrorExpand) -- virtal expand
	],

        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        startupHook        = myStartupHook,
        logHook            = dynamicLogWithPP $ xmobarPP
		{ ppOutput = hPutStrLn xmproc 
                , ppCurrent = xmobarColor "#fe8019" "" . wrap "[" "]"           -- Current workspace
                , ppVisible = xmobarColor "#928374" ""                          -- Visible but not current workspace
                , ppHidden = xmobarColor "#d5c4a1" "" . wrap "*" ""             -- Hidden workspaces
                , ppHiddenNoWindows = xmobarColor "#504945" ""                  -- Hidden workspaces (no windows)
								, ppLayout = xmobarColor "#83a598" ""
                , ppTitle = xmobarColor "#ebdbb2" "" . shorten 60               -- Title of active window
                , ppSep =  "<fc=#665c54> <fn=1>|</fn> </fc>"                    -- Separator character
                , ppUrgent = xmobarColor "#fb4934" "" . wrap "!" "!"            -- Urgent workspace
                , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar
		}
    }
