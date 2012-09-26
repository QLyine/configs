--
-- qlyine's xmonad config file.
--
-- Slightly modified default config file, with some stuff from Rob
-- Manea's and meqif's config.
--
 
-- XMonad Core
import XMonad
 
-- Actions
import XMonad.Actions.DwmPromote
import XMonad.Actions.NoBorders
-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageHelpers
-- Layouts
import XMonad.Layout
--import XMonad.Layout.IM     (Property(..), withIM)
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Layout.SimpleFloat
import XMonad.Layout.IM
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
-- Misc
import XMonad.Operations
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Scratchpad

import System.Exit
import System.IO (hPutStrLn)
 
import qualified XMonad.StackSet as W
import qualified Data.Map as M
 
--------------------------------------------------------------------------------
-- Misc commands
--
 
dmenu = "dmenu_run -i -fn '" ++ myFont ++
    "' -nb '#222' -nf '#ccc' -sb '#555' -sf '#fff'"
 
--------------------------------------------------------------------------------
-- Customizations
--
 
-- Where my dzen bitmaps are stored
myIconDir = "/home/qlyine/.icons/dzen_bitmaps/"
 
-- Default font
--myFont = "-*-profont-*-*-*-*-11-*-*-*-*-*-iso8859"
myFont = "Bitstream Vera Sans:Roman:pixelsize=11"
-- Dzen's config
statusBarCmd = "dzen2 -w 550 -sa c -fn '" ++ myFont
                ++ "' -e '' -ta l -h 16 -bg 'black'"
 
-- The preferred terminal program, which is used in a binding below and
-- by certain contrib modules.
--
myTerminal = "urxvtc"
 
-- Width of the window border in pixels.
--
myBorderWidth = 1
 
myModMask = mod1Mask
 
-- The default number of workspaces (virtual screens) and their names.
--
 
myWorkspaceNames :: [String]
myWorkspaceNames = ["main", "web", "code", "im", "doc"] ++ map show [6..9]
 
myWorkspaces :: [WorkspaceId] -- [String]
myWorkspaces = zipWith (++) (map show [1..]) wsnames
    where wsnames = map ((:) ':') myWorkspaceNames
 
getWorkspaceId :: String -> WorkspaceId -- String
getWorkspaceId name = case lookup name (zip myWorkspaceNames myWorkspaces) of
      Just wsId -> wsId
      Nothing -> head myWorkspaces
 
-- Border colors for unfocused and focused windows, respectively.
--
myMainColor          = "#708090"
--myMainColor          = "#ff9900"
--myMainColor          = "#848484"
myNormalBorderColor  = "#444444"
myFocusedBorderColor = myMainColor

myFontColor          = "white"
myHiddenFontColor    = "white"
--------------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    -- launch a terminal
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
 
    -- launch dmenu
    , ((modMask, xK_p ), spawn dmenu)
 
    -- launch firefox
    , ((modMask, xK_f ), spawn "firefox")
 
    -- launch firefox
    , ((modMask, xK_v ), spawn "chromium --proxy-server=\"http://localhost:8118\" ")

    -- launch firefox
    , ((modMask, xK_e ), spawn "eclipse")

    -- launch firefox
    , ((modMask, xK_s ), scratchpadSpawnActionTerminal myTerminal )

    -- launch wunderlist 
    , ((modMask, xK_w ), spawn "chromium --proxy-server=\"http://localhost:8118\" --app=\"http://www.wunderlist.com\"" ) 

    -- launch gmail.com 
    , ((modMask .|. shiftMask, xK_g ), spawn "chromium --proxy-server=\"http://proxy:3128\" --app=\"https://193.136.113.11:4443/OVS/index.jspx\"" )
    
    -- ogame 
    , ((modMask .|. shiftMask, xK_o ), spawn "chromium --app=\"http://10.30.0.11\"" )

    -- ogame 
    , ((modMask, xK_o ), spawn "chromium --proxy-server=\"http://localhost:8118\" --app=\"http://ogame.com.pt\"" )

    -- launch thunar
    , ((modMask .|. shiftMask, xK_t ), spawn "thunar")

    -- launch sonata
    , ((modMask .|. shiftMask, xK_s ), spawn "sonata")

    -- multimedia keys / MPD control
    --, ((mod4Mask, xK_Up ), spawn "mpc toggle")
    , ((mod4Mask, xK_Up), spawn "mpc toggle")
    , ((mod4Mask, xK_Delete ), spawn "mpc stop > /dev/null")
    , ((mod4Mask, xK_Insert ), spawn "mpc play > /dev/null")
    , ((mod4Mask, xK_Home ), spawn "mpc prev > /dev/null")
    , ((mod4Mask, xK_End ), spawn "mpc next > /dev/null")
    , ((mod4Mask, xK_Page_Down ), spawn "amixer set Master 14 > /dev/null")
    , ((mod4Mask, xK_Page_Up ), spawn "amixer set Master 24 > /dev/null")
    , ((0,  0x1008ff13), spawn "amixer set Master 1+ > /dev/null")
    , ((0,  0x1008ff11), spawn "amixer set Master 1- > /dev/null")
    , ((0,  0x1008ff12), spawn "amixer set Master toggle")
    , ((0,  0x1008ff1d), spawn "amixer set Headphone toggle")
    , ((0,  0x1008ff32), spawn "mpd")
 
    -- Print Screen
    , ((0, xK_Print ), spawn "scrot '%Y-%m-%d-%H:%M_$wx$h.png' -e 'mv $f /home/qlyine/Pictures/screenies' > /dev/null")

    -- PC Shutdown
    , ((mod4Mask .|. modMask, xK_F12), spawn "sudo poweroff")

    -- Show school's schedule
    , ((modMask, xK_z ), spawn "feh ~/uniWorkspace/horario/horario.png > /dev/null")

    -- close focused window
    , ((modMask, xK_c ), kill)
    
    -- Rotate through the available layout algorithms
    , ((modMask, xK_space ), sendMessage NextLayout)
 
    -- Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Move focus to the next window
    , ((modMask, xK_Tab ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modMask, xK_j ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modMask, xK_k ), windows W.focusUp )
 
    -- Move focus to the master window
    , ((modMask, xK_m ), windows W.focusMaster )
 
    -- Swap the focused window and the master window
    , ((modMask, xK_Return), dwmpromote)
 
    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j ), windows W.swapDown )
 
    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k ), windows W.swapUp )
 
    , ((modMask, xK_g ), withFocused toggleBorder )
 
    -- Shrink the master area
    , ((modMask, xK_h ), sendMessage Shrink)
 
    -- Expand the master area
    , ((modMask, xK_l ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modMask, xK_t ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modMask , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modMask , xK_period), sendMessage (IncMasterN (-1)))
 
    -- toggle the status bar gap
    ,((modMask , xK_b ), sendMessage ToggleStruts)
 
    -- Quit xmonad
    , ((modMask .|. shiftMask, xK_q ), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modMask .|. controlMask , xK_r ),
        broadcastMessage ReleaseResources >> restart "xmonad" True)
    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
 
    ++
    -- mod-{a,o} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{a,o} %! Move client to screen 1, 2, or 3
    [((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_1, xK_2] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
 
--------------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
 
    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
    ]
 
--------------------------------------------------------------------------------
-- Layouts:
 
myLayout = onWorkspace (getWorkspaceId "im") imL
         $ onWorkspace (getWorkspaceId "code") codeL
         $ onWorkspace (getWorkspaceId "doc") docL
         $ restL
         where
             tiled = Tall nmaster delta ratio
             nmaster = 1
             ratio = 1/2
             delta = 3/100
 
             mtile = Mirror (tiled)
 
             imL = avoidStruts $ (withIM (1/6) (Role "buddy_list") Grid) 

             codeL = avoidStruts $ smartBorders $ layoutHints 
                                   $ (Tall nmaster delta (56/100) ||| mtile ||| Full)
             docL = avoidStruts $ smartBorders $ layoutHints
                                   $ (Full ||| tiled ||| mtile)

             restL = avoidStruts $ smartBorders $ layoutHints
                                   $ ( Tall nmaster delta (63/100) ||| mtile ||| Full ||| simpleFloat)
 
--------------------------------------------------------------------------------
-- Window rules:
 
myManageHook :: ManageHook
myManageHook = mainManageHook <+> manageFullScreen <+> manageDocks <+> manageScratchPad

    where

        mainManageHook = composeAll $ concat 
            [ [ className =? c --> doFloat | c <- myFloats ]
            , [ title =? t --> doFloat | t <- myOtherFloats ]
            , [ className =? webC --> doF (W.shift $ getWorkspaceId "web" ) | webC <- web ]
            , [ className =? imC --> doF (W.shift $ getWorkspaceId "im") | imC <- im ]
            , [ className =? docC --> doF (W.shift $ getWorkspaceId "doc") | docC <- doc ]
            , [ className =? codeC --> doF (W.shift $ getWorkspaceId "code") | codeC <- code ]
            , [ className =? "Qwit" --> (ask >>= doF . W.sink) ]
            , [ className =? "stalonetray" --> doIgnore ] ] 
        
        manageFullScreen = isFullscreen --> doFullFloat

        manageScratchPad :: ManageHook
        manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
          where
            h = 0.5     -- terminal height, 10%
            w = 0.6     -- terminal width, 100%
            t = 1 - h   -- distance from top edge, 90%
            l = (1 - w)/2   -- distance from left edge, 0%

        code = [ "Eclipse", "Eclipse SDK", ".", "Kate" ]
        doc = [ "Kile", "Evince", "Zathura","OpenOffice.org 3.0"]
        web = [ "Gran Paradiso", "Firefox", "Opera", "Namoroka", "Chrome" ]
        im = [ "Pidgin", "gajim.py" ]
        myFloats = ["MPlayer", "mplayer2", "Gimp", "Sonata", "feh", "fbpanel",
                    "Mirage", "gens", "Skype", "wine","Nitrogen",
                    "Save a Bookmark", "Smplayer", "Eclipse SDK", "."]
        myOtherFloats = ["Gran Paradiso - Restore Previous Session", "Add-ons",
                         "Downloads", "Gajim", "gens", "Wicd Manager",
                         "Nitrogen", "Save a Bookmark", "emesene",
                         "VLC media player"]
 
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
 
--------------------------------------------------------------------------------
-- Logging
 
myPP h = defaultPP
    { --ppCurrent = dzenColor "white" myMainColor . pad
    ppCurrent = dzenColor "#F92672" "" . pad
    , ppVisible = wrap "<" ">"
    , ppHidden = dzenColor  myHiddenFontColor "" . pad 
    , ppUrgent = wrap "^fg(red)^bg() +" " ^fg()^bg()"
    , ppSep = " "
    , ppLayout = dzenColor myFontColor "" .
        (\x -> case x of
            "Hinted Tall" -> "^i(" ++ myIconDir ++ "tall.xbm)"
            "Tall" -> "^i(" ++ myIconDir ++ "tall.xbm)"
            "Hinted Mirror Tall" -> "^i(" ++ myIconDir ++ "mtall.xbm)"
            "Mirror Tall" -> "^i(" ++ myIconDir ++ "mtall.xbm)"
            "Hinted Full" -> "^i(" ++ myIconDir ++ "full.xbm)"
            "Full" -> "^i(" ++ myIconDir ++ "full.xbm)"
            "Hinted Simple Float" -> "><>"
            "Simple Float" -> "><>"
            _ -> x
        )
    , ppTitle = dzenColor myFontColor "" . wrap "< " " >"
    , ppOutput = System.IO.hPutStrLn h

}
 

--------------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--

main = do
    din <- spawnPipe statusBarCmd
    xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
      -- simple stuff
        terminal = myTerminal,
        focusFollowsMouse = myFocusFollowsMouse,
        borderWidth = myBorderWidth,
        modMask = myModMask,
        workspaces = myWorkspaces,
        normalBorderColor = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
 
      -- Fix For Java Aplications
        startupHook = setWMName "LG3D",

      -- key bindings
        keys = myKeys,
        mouseBindings = myMouseBindings,
 
      -- hooks, layouts
        layoutHook = myLayout,
        manageHook = myManageHook <+> manageDocks,
        logHook    = do fadeInactiveLogHook 0.87 
                        dynamicLogWithPP $ myPP din
    }


