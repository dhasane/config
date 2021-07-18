

-- --
-- -- xmonad example config file for xmonad-0.9
-- --
-- -- A template showing all available configuration hooks,
-- -- and how to override the defaults in your own xmonad.hs conf file.
-- --
-- -- Normally, you'd only override those defaults you care about.
-- --
-- -- NOTE: Those updating from earlier xmonad versions, who use
-- -- EwmhDesktops, safeSpawn, WindowGo, or the simple-status-bar
-- -- setup functions (dzen, xmobar) probably need to change
-- -- xmonad.hs, please see the notes below, or the following
-- -- link for more details:
-- --
-- -- http://www.haskell.org/haskellwiki/Xmonad/Notable_changes_since_0.8
-- --
--
-- import XMonad
-- import Data.Monoid
-- import System.Exit
-- import XMonad.Hooks.DynamicLog
-- import XMonad.Hooks.ManageDocks
-- import XMonad.Hooks.EwmhDesktops
-- import XMonad.Util.Run(spawnPipe)
-- import XMonad.Util.EZConfig(additionalKeys)
-- import System.IO
-- import XMonad.Layout.Tabbed
--
-- -- The preferred terminal program, which is used in a binding below and by
-- -- certain contrib modules.
-- --
-- myTerminal      = "kitty"
--
-- -- Whether focus follows the mouse pointer.
-- myFocusFollowsMouse :: Bool
-- myFocusFollowsMouse = True
--
-- -- Width of the window border in pixels.
-- --
-- myBorderWidth   = 2
--
-- -- modMask lets you specify which modkey you want to use. The default
-- -- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- -- ("right alt"), which does not conflict with emacs keybindings. The
-- -- "windows key" is usually mod4Mask.
-- --
-- myModMask       = mod4Mask
--
-- -- NOTE: from 0.9.1 on numlock mask is set automatically. The numlockMask
-- -- setting should be removed from configs.
-- --
-- -- You can safely remove this even on earlier xmonad versions unless you
-- -- need to set it to something other than the default mod2Mask, (e.g. OSX).
-- --
-- -- The mask for the numlock key. Numlock status is "masked" from the
-- -- current modifier status, so the keybindings will work with numlock on or
-- -- off. You may need to change this on some systems.
-- --
-- -- You can find the numlock modifier by running "xmodmap" and looking for a
-- -- modifier with Num_Lock bound to it:
-- --
-- -- > $ xmodmap | grep Num
-- -- > mod2        Num_Lock (0x4d)
-- --
-- -- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- -- numlock status separately.
-- --
-- -- myNumlockMask   = mod2Mask -- deprecated in xmonad-0.9.1
-- ------------------------------------------------------------
--
--
-- -- The default number of workspaces (virtual screens) and their names.
-- -- By default we use numeric strings, but any string may be used as a
-- -- workspace name. The number of workspaces is determined by the length
-- -- of this list.
-- --
-- -- A tagging example:
-- --
-- -- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
-- --
-- myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
--
-- -- Border colors for unfocused and focused windows, respectively.
-- --
-- myNormalBorderColor  = "#cccccc"
-- myFocusedBorderColor = "#cd8b00"
--
-- ------------------------------------------------------------------------
-- -- Key bindings. Add, modify or remove key bindings here.
-- --
-- myKeys conf@XConfig {XMonad.modMask = modm} = M.fromList $
--
--     [
--
--
--     ]
--     ++
--
--     --
--     -- mod-[1..9], Switch to workspace N
--     --
--     -- mod-[1..9], Switch to workspace N
--     -- mod-shift-[1..9], Move client to workspace N
--     --
--     [((m .|. modm, k), windows $ f i)
--         | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
--         , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
--     ++
--
--     --
--     -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
--     -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
--     --
--     [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
--         | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
--         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
--
--
-- ------------------------------------------------------------------------
-- -- Mouse bindings: default actions bound to mouse events
-- --
-- myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList
--
--     -- mod-button1, Set the window to floating mode and move by dragging
--     [
--       ((modm, button1), \w -> focus w >> mouseMoveWindow w
--                                        >> windows W.shiftMaster)
--
--     -- mod-button2, Raise the window to the top of the stack
--     , ((modm, button2), \w -> focus w >> windows W.shiftMaster)
--
--     -- mod-button3, Set the window to floating mode and resize by dragging
--     , ((modm, button3), \w -> focus w >> mouseResizeWindow w
--                                        >> windows W.shiftMaster)
--
--     -- you may also bind events to the mouse scroll wheel (button4 and button5)
--     ]
--
-- ------------------------------------------------------------------------
-- -- Layouts:
--
-- -- You can specify and transform your layouts by modifying these values.
-- -- If you change layout bindings be sure to use 'mod-shift-space' after
-- -- restarting (with 'mod-q') to reset your layout state to the new
-- -- defaults, as xmonad preserves your old layout settings by default.
-- --
-- -- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- -- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- -- Instead use the 'ewmh' function from that module to modify your
-- -- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- -- startupHook ewmh notes.)
-- --
-- -- The available layouts.  Note that each layout is separated by |||,
-- -- which denotes layout choice.
-- --
-- myLayout = simpleTabbed ||| tiled ||| Mirror tiled ||| Full
--   where
--     -- default tiling algorithm partitions the screen into two panes
--     tiled   = Tall nmaster delta ratio
--
--     -- The default number of windows in the master pane
--     nmaster = 1
--
--     -- Default proportion of screen occupied by master pane
--     ratio   = 1/2
--
--     -- Percent of screen to increment by when resizing panes
--     delta   = 3/100
--
-- ------------------------------------------------------------------------
-- -- Window rules:
--
-- -- Execute arbitrary actions and WindowSet manipulations when managing
-- -- a new window. You can use this to, for example, always float a
-- -- particular program, or have a client always appear on a particular
-- -- workspace.
-- --
-- -- To find the property name associated with a program, use
-- -- > xprop | grep WM_CLASS
-- -- and click on the client you're interested in.
-- --
-- -- To match on the WM_NAME, you can use 'title' in the same way that
-- -- 'className' and 'resource' are used below.
-- --
-- myManageHook = composeAll
--     [
--       className =? "MPlayer"        --> doFloat
--     , className =? "Gimp"           --> doFloat
--     , resource  =? "desktop_window" --> doIgnore
--     , resource  =? "kdesktop"       --> doIgnore
--     ]
--
-- ------------------------------------------------------------------------
-- -- Event handling
--
-- -- Defines a custom handler function for X Events. The function should
-- -- return (All True) if the default handler is to be run afterwards. To
-- -- combine event hooks use mappend or mconcat from Data.Monoid.
-- --
-- -- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- -- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- -- It will add EWMH event handling to your custom event hooks by
-- -- combining them with ewmhDesktopsEventHook.
-- --
-- myEventHook = mempty
--
-- ------------------------------------------------------------------------
-- -- Status bars and logging
--
-- -- Perform an arbitrary action on each internal state change or X event.
-- -- See the 'XMonad.Hooks.DynamicLog' extension for examples.
-- --
-- --
-- -- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- -- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- -- It will add EWMH logHook actions to your custom log hook by
-- -- combining it with ewmhDesktopsLogHook.
-- --
-- myLogHook = return ()
--
-- ------------------------------------------------------------------------
-- -- Startup hook
--
-- -- Perform an arbitrary action each time xmonad starts or is restarted
-- -- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- -- per-workspace layout choices.
-- --
-- -- By default, do nothing.
-- --
-- -- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- -- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- -- It will add initialization of EWMH support to your custom startup
-- -- hook by combining it with ewmhDesktopsStartup.
-- --
-- myStartupHook = return ()
--
-- ------------------------------------------------------------------------
-- -- Now run xmonad with all the defaults we set up.
--
-- -- Run xmonad with the settings you specify. No need to modify this.
-- --
-- -- main = xmonad defaults
--
-- -- A structure containing your configuration settings, overriding
-- -- fields in the default config. Any you don't override, will
-- -- use the defaults defined in xmonad/XMonad/Config.hs
-- --
-- -- No need to modify this.
-- --
-- defaults = defaultConfig {
--       -- simple stuff
--         terminal           = myTerminal,
--         focusFollowsMouse  = myFocusFollowsMouse,
--         borderWidth        = myBorderWidth,
--         modMask            = myModMask,
--         -- numlockMask deprecated in 0.9.1
--         -- numlockMask        = myNumlockMask,
--         workspaces         = myWorkspaces,
--         normalBorderColor  = myNormalBorderColor,
--         focusedBorderColor = myFocusedBorderColor,
--
--       -- key bindings
--         keys               = myKeys,
--         mouseBindings      = myMouseBindings,
--
--       -- hooks, layouts
--         layoutHook         = myLayout,
--         manageHook         = myManageHook,
--         handleEventHook    = myEventHook,
--         logHook            = myLogHook,
--         startupHook        = myStartupHook
--     }
--
-- --Config { font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
--        --, bgColor = "black"
--        --, fgColor = "grey"
--        --, position = TopW L 90
--        --, commands = [
--            --Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 10
--            --, Run Memory ["-t","Mem: <usedratio>%"] 10
--            --, Run Swap [] 10
--            --, Run Date "%a %b %_d %l:%M" "date" 10
--            --, Run StdinReader
--            --]
--        --, sepChar = "%"
--        --, alignSep = "}{"
--        --, template = "%StdinReader% }{ %cpu% | %memory% * %swap%    <fc=#ee9a00>%date%</fc> | %EGPF%"
--        --}
--
-- main = do
--     xmproc <- spawnPipe "xmobar"
--     -- xmonad $ docks defaultConfig
--     xmonad $ ewmh def
--         {
--           -- simple stuff
--           terminal           = myTerminal
--         , focusFollowsMouse  = myFocusFollowsMouse
--         , borderWidth        = myBorderWidth
--         , modMask            = myModMask
--           -- numlockMask deprecated in 0.9.1
--                                -- numlockMask        = myNumlockMask,
--         , workspaces         = myWorkspaces
--         , normalBorderColor  = myNormalBorderColor
--         , focusedBorderColor = myFocusedBorderColor
--
--           -- key bindings
--         , keys               = myKeys
--         , mouseBindings      = myMouseBindings
--
--           -- hooks, layouts
--         , layoutHook         = avoidStruts myLayout
--         , manageHook         = myManageHook
--         -- , handleEventHook    = myEventHook
--         , handleEventHook = mconcat
--                             [
--                               docksEventHook
--                             , handleEventHook defaultConfig
--                             ]
--         , logHook            = dynamicLogWithPP xmobarPP
--         , startupHook        = myStartupHook
--         }
--         -- `additionalKeys`
--         -- [
--         --   ((mod4Mask .|. shiftMask, xK_0), spawn "xscreensaver-command -lock")
--         -- , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
--         -- , ((0, xK_Print), spawn "scrot")
--         -- ]

import XMonad hiding ((|||))
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Useful for rofi
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP, additionalMouseBindings)
import System.IO
import System.Exit
-- Last window
import XMonad.Actions.GroupNavigation
-- Last workspace. Seems to conflict with the last window hook though so just
-- disabled it.
-- import XMonad.Actions.CycleWS
-- import XMonad.Hooks.WorkspaceHistory (workspaceHistoryHook)
import XMonad.Layout.Tabbed
import XMonad.Hooks.InsertPosition
import XMonad.Layout.SimpleDecoration (shrinkText)
-- Imitate dynamicLogXinerama layout
import XMonad.Util.WorkspaceCompare
import XMonad.Hooks.ManageHelpers
-- Order screens by physical location
import XMonad.Actions.PhysicalScreens
import Data.Default
-- For getSortByXineramaPhysicalRule
import XMonad.Layout.LayoutCombinators
-- smartBorders and noBorders
import XMonad.Layout.NoBorders
-- spacing between tiles
import XMonad.Layout.Spacing
-- Insert new tabs to the right: https://stackoverflow.com/questions/50666868/how-to-modify-order-of-tabbed-windows-in-xmonad?rq=1
-- import XMonad.Hooks.InsertPosition

--- Layouts
-- Resizable tile layout
import XMonad.Layout.ResizableTile
-- Simple two pane layout.
import XMonad.Layout.TwoPane
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Dwindle

-- sonido
import Graphics.X11.ExtraTypes.XF86
       (
         xF86XK_AudioLowerVolume,
         xF86XK_AudioRaiseVolume,
         xF86XK_Sleep,
         xF86XK_AudioMute,
         xF86XK_MonBrightnessUp,
         xF86XK_MonBrightnessDown
       )

myTabConfig = def
              { activeColor = "#556064"
              , inactiveColor = "#2F3D44"
              , urgentColor = "#FDF6E3"
              , activeBorderColor = "#454948"
              , inactiveBorderColor = "#454948"
              , urgentBorderColor = "#268BD2"
              , activeTextColor = "#80FFF9"
              , inactiveTextColor = "#1ABC9C"
              , urgentTextColor = "#1ABC9C"
              , fontName = "xft:Noto Sans CJK:size=10:antialias=true"
              }

myLayout = avoidStruts $
  noBorders (tabbed shrinkText myTabConfig)
  ||| tiled
  ||| Mirror tiled
  -- ||| noBorders Full
  ||| twopane
  ||| Mirror twopane
  ||| emptyBSP
  ||| Spiral L XMonad.Layout.Dwindle.CW (3/2) (11/10) -- L means the non-main windows are put to the left.

  where
     -- The last parameter is fraction to multiply the slave window heights
     -- with. Useless here.
     tiled = spacing 3 $ ResizableTall nmaster delta ratio []
     -- In this layout the second pane will only show the focused window.
     twopane = spacing 3 $ TwoPane delta ratio
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myPP = def { ppCurrent = xmobarColor "#1ABC9C" "" . wrap "[" "]"
           , ppTitle = xmobarColor "#1ABC9C" "" . shorten 60
           , ppVisible = wrap "(" ")"
           , ppUrgent  = xmobarColor "red" "yellow"
           , ppSort = getSortByXineramaPhysicalRule def
           }

myManageHook = composeAll [ isFullscreen --> doFullFloat

                          ]

myKeys conf@XConfig {XMonad.modMask = modm} = M.fromList $
    [
    -- launch a terminal
      ((modm , xK_Return), spawn $ XMonad.terminal conf)
      -------------------------------------------------------------------------
      --                                Launch                                --
      -------------------------------------------------------------------------
    , ((modm, xK_F3), spawn "$FILE")
    , ((modm, xK_c), spawn $ XMonad.terminal conf)
    , ((modm, xK_d), spawn "rofi -show combi -font \"monoid regular 10\"")
    , ((modm, xK_s), spawn "rofi -show window -font \"monoid regular 10\"")
    -- screenshots -------------------------------------------------------------
    , ((0, xK_Print), spawn   "scrot -e 'mv $f ~/Screenshots/.'; notify-send 'screenshot taken'")
    -- , ((modm, xK_Print), spawn) -- aqui poner para que haga el snippet
    , ((modm .|. shiftMask, xK_Print), spawn  "scrot -ue 'mv $f ~/Screenshots/.'; notify-send 'screenshot taken'")

      -------------------------------------------------------------------------
      --                                Sonido                               --
      -------------------------------------------------------------------------
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer -D pulse sset Master 5%-")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -D pulse sset Master 5%+")
    , ((0, xF86XK_AudioMute), spawn "pulseaudio-ctl mute toggle")
    , ((0, xF86XK_Sleep), spawn "systemctl suspend ; xlock -mode hop")

      -------------------------------------------------------------------------
      --                             Iluminacion                             --
      -------------------------------------------------------------------------
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight + 5")
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight - 5")

      -------------------------------------------------------------------------
      --                               Layouts                               --
      -------------------------------------------------------------------------

     -- Rotate through the available layout algorithms
    , ((modm, xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm .|. shiftMask, xK_h), sendMessage $ JumpToLayout "Mirror Tall")
    , ((modm .|. shiftMask, xK_v), sendMessage $ JumpToLayout "Tall")
    , ((modm .|. shiftMask, xK_f), sendMessage $ JumpToLayout "Full")
    , ((modm .|. shiftMask, xK_t), sendMessage $ JumpToLayout "Tabbed Simplest")

      -------------------------------------------------------------------------
      --                         Layout manipulation                         --
      -------------------------------------------------------------------------


    ---------------------------------------------------------

    -- Resize viewed windows to the correct size
    , ((modm, xK_n), refresh)

    -- Move focus to the next window
    , ((modm, xK_Tab), windows W.focusDown)

    -- Move focus to the next window
    , ((modm, xK_j), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm, xK_k), windows W.focusUp)

    -- Move focus to the master window
    , ((modm, xK_m), windows W.focusMaster)

    -- Swap the focused window and the master window
    , ((modm, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j), windows W.swapDown)

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k), windows W.swapUp)

    -- Shrink the master area
    , ((modm, xK_h), sendMessage Shrink)

    -- Expand the master area
    , ((modm, xK_l), sendMessage Expand)

    -- Shrink and expand ratio between the secondary panes, for the ResizableTall layout
    , ((modm .|. shiftMask, xK_h), sendMessage MirrorShrink)
    , ((modm .|. shiftMask, xK_l), sendMessage MirrorExpand)

    -- Push window back into tiling
    , ((modm, xK_t), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm, xK_comma), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm, xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    , ((modm, xK_b), sendMessage ToggleStruts)

    -- close focused window
    , ((modm .|. shiftMask, xK_q), kill)

    -- Resize viewed windows to the correct size
    , ((modm .|. shiftMask, xK_r), refresh)

    -- Move focus to the next window
    , ((modm, xK_x), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm, xK_z), windows W.focusUp  )

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_x), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_z), windows W.swapUp    )

    , ((modm .|. shiftMask, xK_0), io exitSuccess)
    -- Restart xmonad
    , ((modm .|. shiftMask, xK_r), spawn "xmonad --recompile; xmonad --restart")

    -- , ((modm .|. shiftMask, xK_0), spawn "xscreensaver-command -lock")
    -- 0 means no extra modifier key needs to be pressed in this case.

    ]

    ++
      [((m .|. modm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
      [((m .|. modm, key), f sc)
      | (key, sc) <- zip [xK_a, xK_s] [0..]
      -- | (key, sc) <- zip [xK_a, xK_s, xK_d] [0..]
      -- Order screen by physical order instead of arbitrary numberings.
      , (f, m) <- [(viewScreen def, 0), (sendToScreen def, shiftMask)]]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ ewmh def
        { modMask = mod4Mask
        , keys = myKeys
        , manageHook = manageDocks <+> myManageHook
        , layoutHook = myLayout
        , handleEventHook = handleEventHook def <+> docksEventHook
        , logHook = dynamicLogWithPP myPP {
                                          ppOutput = hPutStrLn xmproc
                                          }
                        >> historyHook
        , terminal = "$TERMINAL"
        -- This is the color of the borders of the windows themselves.
        , normalBorderColor  = "#2f3d44"
        , focusedBorderColor = "#1ABC9C"
        }
        `additionalKeysP`
        [
          ("M1-<Space>", spawn "rofi -combi-modi window,run,drun -show combi -modi combi")
          , ("C-M1-<Space>", spawn "rofi -show run")
          -- Restart xmonad. This is the same keybinding as from i3
          , ("M-S-c", spawn "xmonad --recompile; xmonad --restart")
          , ("M-'", windows W.swapMaster)
          , ("M1-<Tab>", nextMatch History (return True))
          , ("M-<Return>", spawn "lxterminal")
          -- Make it really hard to mispress...
          , ("M-M1-S-l", spawn "i3lock")
          , ("M-M1-S-s", spawn "i3lock && systemctl suspend")
          , ("M-M1-S-h", spawn "i3lock && systemctl hibernate")
        ] `additionalMouseBindings`
        [ ((mod4Mask, button4), \w -> windows W.focusUp)
        , ((mod4Mask, button5), \w -> windows W.focusDown)
        ]
