import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.FadeInactive
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Themes
import XMonad.Util.Loggers
import System.IO
import System.Exit
import XMonad.Layout.NoBorders
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.Tabbed
import XMonad.Layout.LayoutScreens
import XMonad.Layout.TwoPane
import XMonad.Actions.WindowBringer
import XMonad.Prompt
import XMonad.Prompt.Ssh

import qualified Data.Map as M
import qualified XMonad.StackSet as W

main=xmonad=<< myStatusBar myConfig

toggleStrutsKey  XConfig { XMonad.modMask = myModMask } = (myModMask, xK_b)

myFadeInactiveLogHook = fadeInactiveLogHook fadeAmount
	where fadeAmount = 0.8

webBrowser	  = "firefox"
webBrowser'	  = "/usr/local/bin/chromium"
myTerminal    = "xterm"
myTerminal'   = "urxvt"
myScreenLock  = "xscreensaver-command -lock"
myModMask	  = mod4Mask
myNumlockMask = mod2Mask

myStatusBar   = statusBar myBar myPP toggleStrutsKey
	where
		myPP  = xmobarPP { ppExtras = [ padL loadAvg ] }
		-- myBar = "xmobar /home/stelterd/.xmonad/xmobar.config"
		myBar = "xmobar"
		-- myBar = "xmobar /home/stelterd/.xmonad/xmobar.config"

myManageHook = manageDocks <+> manageHook defaultConfig <+> composeOne [ isFullscreen -?> doFullFloat ]

myLayout = avoidStruts (myFull ||| myTall ||| myTabbed)
	where
		myTall	 = workspaceDir "~" (Tall 1 (3/100) (488/792))
		myFull   = workspaceDir "~" (noBorders Full)
		myTabbed = workspaceDir "~" (noBorders $ tabbed shrinkText defaultTheme)

myConfig = defaultConfig
		{ normalBorderColor	 = "#181818"
		, focusedBorderColor = "#0077cc"
		, manageHook	= myManageHook
		, layoutHook	= myLayout
        , terminal      = myTerminal'
		, logHook	    = myFadeInactiveLogHook >> setWMName "LG3D"
		-- , numlockMask	= myNumlockMask
		, keys          = myKeys
		}


myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    [ ((modShiftMask,        xK_Return), spawn $ XMonad.terminal conf)

    -- , ((modMask,                                   xK_p), spawn "exe=`dmenu_path | dmenu -nb black -nf grey -sb orange -sf black` && eval \"exec $exe\"")
    , ((modMask,                  xK_p), spawn "dmenu_run")

	-- play/pause mpd
	, ((modShiftMask,        xK_p     ), spawn "mpc toggle")
	-- prev track mpd
	, ((modShiftMask,        xK_comma ), spawn "mpc prev")
	-- next track mpd
	, ((modShiftMask,        xK_period), spawn "mpc next")
	-- vol up 5%
	, ((modShiftMask,        xK_equal ), spawn "mpc volume +5")
	-- vol down 5%
	, ((modShiftMask,        xK_minus ), spawn "mpc volume -5")
    -- WorkspaceDir
    , ((modShiftMask,        xK_x     ), changeDir defaultXPConfig)
    -- lock screen
    , ((modShiftMask,        xK_l     ), spawn myScreenLock)
    -- launch webBrowser
    , ((modShiftMask,        xK_f     ), spawn webBrowser)
    -- launch webBrower'
    , ((modShiftMask,        xK_y     ), spawn webBrowser')
    -- close focused window
    , ((modShiftMask,        xK_c     ), kill)
    -- WindowBringer
    , ((modShiftMask,        xK_g     ), gotoMenu)
    , ((modShiftMask,        xK_b     ), bringMenu)
     -- Rotate through the available layout algorithms
    , ((modMask,             xK_space ), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modShiftMask,        xK_space ), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
    , ((modMask,             xK_n     ), refresh)
    -- Move focus to the next window
    , ((modMask,             xK_Tab   ), windows W.focusDown)
    -- Move focus to the next window
    , ((modMask,             xK_j     ), windows W.focusDown)
    -- Move focus to the previous window
    , ((modMask,             xK_k     ), windows W.focusUp)
    -- Move focus to the master window
    , ((modMask,             xK_m     ), windows W.focusMaster)
    -- Swap the focused window and the master window
    , ((modMask,             xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window
    , ((modShiftMask,        xK_j     ), windows W.swapDown)
    -- Swap the focused window with the previous window
    , ((modShiftMask,        xK_k     ), windows W.swapUp)
    -- Shrink the master area
    , ((modMask,             xK_h     ), sendMessage Shrink)
    -- Expand the master area
    , ((modMask,             xK_l     ), sendMessage Expand)
    -- Push window back into tiling
    , ((modMask,             xK_t     ), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
    , ((modMask,             xK_comma ), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
    , ((modMask,             xK_period), sendMessage (IncMasterN (-1)))
    -- Quit xmonad
    , ((modShiftMask,        xK_q     ), io (exitWith ExitSuccess))
    -- Restart xmonad
    , ((modMask,             xK_q     ), restart "xmonad" True)
	-- SSH
	, ((modShiftMask,        xK_s     ), sshPrompt defaultXPConfig)
	-- twin layouts in one monitor
	, ((modShiftMask,        xK_space ), layoutScreens 2 (TwoPane 0.5 0.5))
	, ((modShiftControlMask, xK_space ), rescreen)
    ]

    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
     -- ++

     ----
     ---- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
     ---- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
     ----
     --[((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
     --    | (key, sc) <- zip [xK_e, xK_w, xK_r] [0..]
     --    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
	 --]
	where
		modShiftMask        = modMask .|. shiftMask
		modControlMask      = modMask .|. controlMask
		modShiftControlMask = modMask .|. shiftMask .|. controlMask

