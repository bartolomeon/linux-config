import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ICCCMFocus
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

import XMonad.Actions.Volume
import XMonad.Actions.GridSelect
import XMonad.Actions.WindowBringer
import XMonad.Actions.FloatKeys

import XMonad.Layout.Spacing 
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.Combo
import XMonad.Layout.DragPane
import XMonad.Layout.Accordion
import XMonad.Layout.Named
import XMonad.Layout.WindowNavigation
import XMonad.Layout.IM as IM
import XMonad.Layout.Minimize
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.IM as IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import Data.Ratio ((%))

import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.Man
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Workspace
import XMonad.Prompt.AppendFile
import XMonad.Prompt.Window
import XMonad.Util.Run
import XMonad.Hooks.SetWMName
 
import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Prompt.MPD
import qualified Network.MPD as MPD

import Data.Monoid

-- | Width of the window border in pixels.
-- --
myBorderWidth :: Dimension
myBorderWidth = 1

-- | Border colors for unfocused and focused windows, respectively.
-- --
myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor  = "black" -- "#dddddd"
myFocusedBorderColor = "green"  -- "#ff0000" don't use hex, not <24 bit safe

fullFloatFocused = withFocused $ \f -> windows =<< appEndo `fmap` runQuery doFullFloat f

-- TODO: would still like fullscreen flash vids to not crop and leave xmobar drawn
-- TODO: remove the red border when doing fullscreen? tried adding 'smartBorders' to the layoutHook but that didn't work
-- TODO: hook in TopicSpaces, start specific apps on specific workspaces

myXPConfig = defaultXPConfig {
               --font = "-*-terminus-*-*-*-*-*-72-*-*-*-*-u",
               font = "xft:Bitstream Vera Sans Mono:size=10:antialias=true" ,
               bgColor = "black",
               fgColor = "wheat",
               fgHLight = "white",
               bgHLight = "red",
               borderColor = "DarkRed",
               position = Top,
               height = 20,
			   promptBorderWidth = 2
}



myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ,  className =? "Skype" --> doF (W.shift "chat")
    ]
 
myWorkspaces = ["1:chat","2:web","3","4:code","5:mail","6","7","8:media"]  
  

oldmyLayout = avoidStruts $ tiled ||| Mirror tiled ||| Full  
   where  
      -- default tiling algorithm partitions the screen into two panes  
      tiled = spacing 5 $ Tall nmaster delta ratio  
      --tiled   = named "Default" (ResizableTall 1 (1/100) (1/2) [])
   
      -- The default number of windows in the master pane  
      nmaster = 1  
   
      -- Default proportion of screen occupied by master pane  
      ratio = 2/3  
   
      -- Percent of screen to increment by when resizing panes  
      delta = 5/100  

-- Define the default layout
skypeLayout = IM.withIM (1%7) (IM.And (ClassName "Skype")  (Role "MainWindow")) Grid
normalLayout = spacing 5 $ smartBorders $ windowNavigation $ minimize $ avoidStruts $ onWorkspace "1:chat" skypeLayout $ layoutHook defaultConfig
myLayout = toggleLayouts (Full) normalLayout 


main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/bartek/.xmonad/xmobarrc"
  xmonad $ defaultConfig {
	XMonad.focusedBorderColor	 = myFocusedBorderColor
	, XMonad.normalBorderColor	 = myNormalBorderColor
    , XMonad.borderWidth       	 = myBorderWidth
    , workspaces = myWorkspaces
    , modMask = mod4Mask, 
    terminal = "xterm",
    startupHook = setWMName "LG3D",
    manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig,
    -- layoutHook = avoidStruts $ layoutHook defaultConfig,
    layoutHook = myLayout  
    ,logHook = dynamicLogWithPP  $ xmobarPP
                       {  ppOutput = hPutStrLn xmproc,
                          ppTitle = xmobarColor "green" "black" .
			  shorten 90
                       }
   } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((mod4Mask, xK_a), spawn "xmessage -file /home/bartek/notes.txt")
	, ((mod4Mask .|. controlMask, xK_Left), withFocused (keysResizeWindow (-30,0) (0,0)))       --Shrink floated window horizontally by 50 pixels
	, ((mod4Mask .|. controlMask, xK_Right), withFocused (keysResizeWindow (30,0) (0,0)))       --Expand floated window horizontally by 50 pixels
	, ((mod4Mask .|. controlMask, xK_Up), withFocused (keysResizeWindow (0,-30) (0,0)))         --Shrink floated window verticaly by 50 pixels
	, ((mod4Mask .|. controlMask, xK_Down), withFocused (keysResizeWindow (0,30) (0,0)))        --Expand floated window verticaly by 50 pixels
        -- Various prompts
        , ((mod4Mask, xK_v), workspacePrompt myXPConfig (windows . W.greedyView))
        , ((mod4Mask .|. shiftMask, xK_v), workspacePrompt myXPConfig (windows . W.shift))
        , ((mod4Mask, xK_p), runOrRaisePrompt myXPConfig)
        , ((mod4Mask, xK_y), manPrompt myXPConfig)
	, ((mod4Mask .|. shiftMask, xK_f), fullFloatFocused)  
	, ((mod4Mask, xK_F2), addMatching MPD.withMPD defaultXPConfig [MPD.Artist, MPD.Album] >> return ())
	, ((0, xF86XK_Launch8    ), spawn "mpc --no-status prev")   -- mod1-z %! MPD: Play the previous song in the current playlist
	, ((0, xF86XK_Launch9  ), spawn "mpc --no-status next")   -- mod1-b %! MPD: Play the next song in the current playlist
	, ((0, xF86XK_AudioPrev    ), spawn "mpc --no-status prev")   -- mod1-z %! MPD: Play the previous song in the current playlist
	, ((0, xF86XK_AudioNext  ), spawn "mpc --no-status next")   -- mod1-b %! MPD: Play the next song in the current playlist
	, ((0, xF86XK_AudioPlay   ), spawn "mpc --no-status toggle") -- mod1-c %! MPD: Toggle play/pause, play if stopped
	, ((0, xF86XK_AudioStop   ), spawn "mpc --no-status stop")   -- mod1-v %! MPD: Stop the currently playing playlists
	, ((mod4Mask,     xK_s     ), sendMessage ToggleStruts) -- mod1-s %! Toggle the status bar gap
	, ((mod4Mask, xK_n), appendFilePrompt myXPConfig "/home/bartek/notes.txt")
	, ((mod4Mask,               xK_m  ), withFocused minimizeWindow)
	, ((mod4Mask .|. shiftMask, xK_m  ), sendMessage RestoreNextMinimizedWin)
        , ((mod4Mask .|. shiftMask, xK_g     ), windowPromptGoto defaultXPConfig { autoComplete = Just 500000 } )
        , ((mod4Mask .|. shiftMask, xK_b     ), windowPromptBring defaultXPConfig)
        -- media
        --, ((mod4Mask, xF86XK_AudioLowerVolume ), lowerVolume 3 >> return ())
        --, ((mod4Mask, xF86XK_AudioLowerVolume ), lowerVolume 3 >> return ())
        --, ((0, xF86XK_AudioRaiseVolume ), spawn "aumix -v+3" )
        --, ((0, xF86XK_AudioRaiseVolume ), spawn "aumix -v-3" )
        , ((0, 0x1008ff11), (spawn $ "aumix -v -3"))
        , ((0, 0x1008ff13), (spawn $ "aumix -v +3"))
        --, ((0, xF86XK_AudioMute ), spawn "aumix -vm" )
        --, ((mod4Mask, xF86XK_AudioMute ), toggleMute    >> return ())
        , ((0, 0x1008ff12), spawn "amixer set Master toggle > /dev/null")
	, ((mod4Mask, xK_F5), spawn "disper -s")
	, ((mod4Mask, xK_F6), spawn "disper -S")
        ]


