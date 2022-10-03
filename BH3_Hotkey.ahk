﻿;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;Version 0.3.5
;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【命令 Directive】引用库文件FindText.ahk
#include <FindText>

;【命令 Directive】修改AHK的默认掩饰键
#MenuMaskKey vkE8  ; vkE8尚未映射

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【函数 Function】管理输入法
SwitchIME(dwLayout)
{
    HKL := DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus, ctl, A
    SendMessage, 0x50, 0, HKL, %ctl%, A
}

;【函数 Function】界面状态栏
Disable( )
{
    WinGet, id, ID, A
    menu := DLLCall("user32\GetSystemMenu", "UInt", id, "UInt", 0)
    DLLCall("user32\DeleteMenu", "UInt", menu, "UInt", 0xF060, "UInt", 0x0)
    WinGetPos ,x, y, w, h, ahk_id %id%
    WinMove, ahk_id %id%,, %x%, %y%, %w%, % h-1
    WinMove, ahk_id %id%,, %x%, %y%, %w%, % h+1
}

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【位置 Path】设定位置
INI_DIR = C:\BH3_Hotkey.ini

;【配置 INI】创建配置
IfNotExist, %INI_DIR%
{
    IniRead, Key_MainSkill, %INI_DIR%, Key Maps, 必杀技, Q
    IniRead, Key_SecondSkill, %INI_DIR%, Key Maps, 武器技/后崩技, E
    IniRead, Key_DollSkill, %INI_DIR%, Key Maps, 人偶技/月之环, Z
    IniRead, Key_Dodging1, %INI_DIR%, Key Maps, 闪避1, LShift
    IniRead, Key_Dodging2, %INI_DIR%, Key Maps, 闪避2, RButton
    IniRead, Key_NormalAttack, %INI_DIR%, Key Maps, 普攻, LButton
    ;IniRead, Key_LeftClick, %INI_DIR%, Key Maps, 正常点击, LAlt + LButton
    IniRead, Key_ViewControl, %INI_DIR%, Key Maps, 管理视角跟随, MButton
    IniRead, Key_Suspend, %INI_DIR%, Key Maps, 暂停/启用, F1
    IniRead, Key_SurfaceCheck, %INI_DIR%, Key Maps, 调出界面, F3

    IniRead, RunAsAdmin, %INI_DIR%, CheckBox, 管理员权限, 1 ; Check by default
    IniRead, EnableAutoScale, %INI_DIR%, CheckBox, 全自动识别, 1 ; Check by default
    IniRead, EnableOcclusion, %INI_DIR%, CheckBox, 可隐藏光标, 0 ; Uncheck by default
    IniRead, EnableRestriction, %INI_DIR%, CheckBox, 限制性光标, 1 ; Check by default
}
Else
{
    IniRead, Key_MainSkill, %INI_DIR%, Key Maps, 必杀技
    IniRead, Key_SecondSkill, %INI_DIR%, Key Maps, 武器技/后崩技
    IniRead, Key_DollSkill, %INI_DIR%, Key Maps, 人偶技/月之环
    IniRead, Key_Dodging1, %INI_DIR%, Key Maps, 闪避1
    IniRead, Key_Dodging2, %INI_DIR%, Key Maps, 闪避2
    IniRead, Key_NormalAttack, %INI_DIR%, Key Maps, 普攻
    ;IniRead, Key_LeftClick, %INI_DIR%, Key Maps, 正常点击
    IniRead, Key_ViewControl, %INI_DIR%, Key Maps, 管理视角跟随
    IniRead, Key_Suspend, %INI_DIR%, Key Maps, 暂停/启用
    IniRead, Key_SurfaceCheck, %INI_DIR%, Key Maps, 调出界面

    IniRead, RunAsAdmin, %INI_DIR%, CheckBox, 管理员权限
    IniRead, EnableAutoScale, %INI_DIR%, CheckBox, 全自动识别
    IniRead, EnableOcclusion, %INI_DIR%, CheckBox, 可隐藏光标
    IniRead, EnableRestriction, %INI_DIR%, CheckBox, 限制性光标
}

;【界面 GUI】说明界面
Gui, Start: + Theme
Gui, Start: Font, s12, 新宋体
Gui, Start: Add, Tab3,, 键位|功能|更新

Gui, Start: Tab, 键位
Gui, Start: Add, Text, Xm+18 Ym+18 ; 控距
Gui, Start: Add, GroupBox, W333 H201, 战斗 Combat
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15,    :                       必杀技
Gui, Start: Add, Hotkey, Xp Yp W87 vKey_MainSkill,    %Key_MainSkill%
Gui, Start: Add, Text, Xp Yp+33,    :                       武器技/后崩技
Gui, Start: Add, Hotkey, Xp Yp W87 vKey_SecondSkill,  %Key_SecondSkill%
Gui, Start: Add, Text, Xp Yp+33,    :                       人偶技/月之环
Gui, Start: Add, Hotkey, Xp Yp W87 vKey_DollSkill,    %Key_DollSkill%
Gui, Start: Add, Text, Xp Yp+33,    :                       闪避
Gui, Start: Add, Hotkey, Xp Yp W36 vKey_Dodging1,     %Key_Dodging1%
Gui, Start: Add, Text, Xp+39 Yp, /
Gui, Start: Add, Hotkey, Xp+12 Yp W36 vKey_Dodging2,  %Key_Dodging2%
Gui, Start: Add, Text, Xp-51 Yp+33, :                       普攻
Gui, Start: Add, Hotkey, Xp Yp W87 vKey_NormalAttack, %Key_NormalAttack%
Gui, Start: Add, Text, Xm+18 Yp+36 ; 控距
Gui, Start: Add, GroupBox, W333 H168, 其它 Others
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15,    左Alt+左键:             正常点击
;Gui, Start: Add, Hotkey, Xp Yp W87 vKey_LeftClick,   %Key_LeftClick%
Gui, Start: Add, Text, Xp Yp+33,    :                       管理视角跟随
Gui, Start: Add, Hotkey, Xp Yp W87 vKey_ViewControl,  %Key_ViewControl%
Gui, Start: Add, Text, Xp Yp+33,    :                       暂停/启用
Gui, Start: Add, Hotkey, Xp Yp W87 vKey_Suspend,      %Key_Suspend%
Gui, Start: Add, Text, Xp Yp+33,    :                       调出界面
Gui, Start: Add, Hotkey, Xp Yp W87 vKey_SurfaceCheck, %Key_SurfaceCheck%
Gui, Start: Add, Text, Xm+18 Yp+36 ; 控距

Gui, Start: Tab, 功能
Gui, Start: Add, Text, Xm+18 Ym+18 ; 控距
Gui, Start: Add, GroupBox, W333 H174, 选项 Options
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, CheckBox, Xp Yp+15 vRunAsAdmin Checked%RunAsAdmin%, 启用管理员权限（推荐）
Gui, Start: Add, CheckBox, Xp Yp+33 vEnableAutoScale Checked%EnableAutoScale%, 启用全自动识别（推荐）
Gui, Start: Add, CheckBox, Xp Yp+33 vEnableOcclusion Checked%EnableOcclusion%, 启用可隐藏光标（实验）
Gui, Start: Add, CheckBox, Xp Yp+33 vEnableRestriction Checked%EnableRestriction%, 启用限制性光标（推荐）

Gui, Start: Tab, 更新
Gui, Start: Add, Text, Xm+18 Ym+18 ; 控距
Gui, Start: Add, GroupBox, W333 H105, 链接 Links
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Link, Xp Yp+15, 百度云:                 <a href="https://pan.baidu.com/s/1KK1B-r-hx_s3yTRl_h_oOg">提取码:2022</a>
Gui, Start: Add, Link, Xp Yp+33, Github:                 <a href="https://github.com/Spartan711/Genshin-to-Honkai-PC-Control-Project/releases">New Release</a>
Gui, Start: Add, Text, Xm+18 Yp+39 ; 控距
Gui, Start: Add, GroupBox, W333 H78, 日志 Logs
Gui, Start: Add, Text, Xp+18 Yp+18 ; 集体缩进
Gui, Start: Add, Text, Xp Yp+15, 版本:
Gui, Start: Add, DDL, Xp+192 Yp W87 gSelectVersion vVersion, v0.3.0|v0.2.+|v0.1.+

Gui, Start: Tab
Gui, Start: Add, Button, Default W366, 开启
Gui, Start: Add, Button, W366, 退出
Gui, Start: Show, xCenter yCenter, 启动界面
Disable( )
Suspend, On
Return

;【例程 Gosub】“版本”选项的执行语句
SelectVersion:
GuiControlGet, Version
Switch Version
{
    Case "v0.3.+":

    Case "v0.2.+":

    Case "v0.1.+":

}
Return

;【标签 Label】“开启”按钮的执行语句
StartButton开启:

Gui, Submit

;【配置 INI】写入配置
IniWrite, %Key_MainSkill%, %INI_DIR%, Key Maps, 必杀技
IniWrite, %Key_SecondSkill%, %INI_DIR%, Key Maps, 武器技/后崩技
IniWrite, %Key_DollSkill%, %INI_DIR%, Key Maps, 人偶技/月之环
IniWrite, %Key_Dodging1%, %INI_DIR%, Key Maps, 闪避1
IniWrite, %Key_Dodging2%, %INI_DIR%, Key Maps, 闪避2
IniWrite, %Key_NormalAttack%, %INI_DIR%, Key Maps, 普攻
;IniWrite, %Key_LeftClick%, %INI_DIR%, Key Maps, 正常点击
IniWrite, %Key_ViewControl%, %INI_DIR%, Key Maps, 管理视角跟随
IniWrite, %Key_Suspend%, %INI_DIR%, Key Maps, 暂停/启用
IniWrite, %Key_SurfaceCheck%, %INI_DIR%, Key Maps, 调出界面

IniWrite, %RunAsAdmin%, %INI_DIR%, CheckBox, 管理员权限
IniWrite, %EnableAutoScale%, %INI_DIR%, CheckBox, 全自动识别
IniWrite, %EnableOcclusion%, %INI_DIR%, CheckBox, 可隐藏光标
IniWrite, %EnableRestriction%, %INI_DIR%, CheckBox, 限制性光标

Gui, Start: Destroy

If (Key_MainSkill != "")
    Hotkey, %Key_MainSkill%, Key_MainSkill
Hotkey, %Key_SecondSkill%, Key_SecondSkill
Hotkey, %Key_DollSkill%, Key_DollSkill
Hotkey, %Key_Dodging1%, Key_Dodging1
Hotkey, %Key_Dodging2%, Key_Dodging2
Hotkey, %Key_NormalAttack%, Key_NormalAttack
;Hotkey, %Key_LeftClick%, Key_LeftClick
If (Key_ViewControl != "")
    Hotkey, %Key_ViewControl%, Key_ViewControl
Hotkey, %Key_Suspend%, Key_Suspend
Hotkey, %Key_SurfaceCheck%, Key_SurfaceCheck

If (RunAsAdmin)
{
    full_command_line := DllCall("GetCommandLine", "str")
    If Not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
    {
        Try
        {
            If A_IsCompiled
                Run *RunAs "%A_ScriptFullPath%" /restart
            Else
                Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
        ExitApp
    }
}
If (EnableAutoScale)
{
    If (!Toggle_AutoScale)
    {
        Toggle_AutoScale := !Toggle_AutoScale
        SetTimer, AutoScale, 81 ; [可调校数值 adjustable parameters] 设定自动识别命令的每执行时间间隔(ms)，如果值过小可能不好使
    }
    Else
    {
        MsgBox, 0, 警告, 检测到参数异常，即将退出程序
        ExitApp
    }
}
If (EnableOcclusion)
{
    If (!Toggle_Occlusion)
    {
        Toggle_Occlusion := !Toggle_Occlusion
    }
    Else
    {
        MsgBox, 0, 警告, 检测到参数异常，即将退出程序
        ExitApp
    }
}
If (EnableRestriction)
{
    If (!Toggle_Restriction)
    {
        Toggle_Restriction := !Toggle_Restriction
    }
    Else
    {
        MsgBox, 0, 警告, 检测到参数异常，即将退出程序
        ExitApp
    }
}

SetTimer, AutoFadeMsgbox, -3000 ; [可调校数值 adjustable parameters] 使消息弹窗仅存在一段时间(ms)
MsgBox, 0, 提示, 程序启动成功(/≧▽≦)/，祝游戏愉快！`n（当前对话框将于3秒后自动消失）
SetTimer, AutoFadeMsgbox, Off
Suspend, Off
Return

;【标签 Label】让对话框自动消失
AutoFadeMsgbox:
DLLCall("AnimateWindow", UInt, WinExist("提示 ahk_class #32770"), Int, 500, UInt, 0x90000)
Return

;【标签 Label】“退出”按钮的执行语句
StartButton退出:
If WinExist("ahk_exe BH3.exe")
{
    MsgBox, 4,, 检测到崩坏3正在运行\(≧□≦)/，真的要退出吗？
    IfMsgBox, Yes
        ExitApp
}
Else
{
    MsgBox, 4,, 是否确认退出当前程序(・-・*)？
    IfMsgBox, Yes
        ExitApp
}
Return

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【命令 Directive】检测崩坏3游戏窗口，使程序仅在崩坏3游戏运行时生效
#IfWinActive ahk_exe BH3.exe

;【常量 Const】对管理自动控制功能的全局常量进行赋值
Global Toggle_AutoScale := 0

;【常量 Const】对管理隐藏光标功能的全局常量进行赋值
Global Toggle_Occlusion := 0
Global Status_Occlusion

;【常量 Const】对管理限制光标功能的全局常量进行赋值
Global Toggle_Restriction := 0
Global x1
Global y1

;【常量 Const】对管理鼠标控制功能的全局常量进行赋值
Global Toggle_MouseFunction := 0

;【常量 Const】对管理视角跟随功能的全局常量进行赋值
Global Status_ViewControl := 0

;【常量 Const】对管理准星跟随功能的全局常量进行赋值
Global BreakFlag_Aim := 0
Global Status_w := 0
Global Status_a := 0
Global Status_s := 0
Global Status_d := 0

;【常量 Const】对管理图像识别功能的全局常量进行赋值
Global Status_CombatIcon := 0
Global Status_ElysiumIcon := 0

;【常量 Const】对管理手动暂停功能的全局常量进行赋值
Global Toggle_ManualSuspend := 0

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【函数 Function】隐藏光标
Occlusion(Status_Occlusion)
{
    If WinActive("ahk_exe BH3.exe")
    {
        If(Toggle_Occlusion)
        {
            If(Status_Occlusion)
            {
                MouseGetPos, , , HWND
                Gui, Cursor: +Owner%HWND%
                DllCall("ShowCursor", "UInt", 0)
            } 
            Else 
            {
                DllCall("ShowCursor", "UInt", 1)
            }
        }
    }
}

;【函数 Function】重置光标
CoordReset()
{
    If WinActive("ahk_exe BH3.exe")
    {
        CoordMode, Window
        WinGetPos, ClientUpperLeftCorner_X, ClientUpperLeftCorner_Y, Client_Width, Client_Height, ahk_exe BH3.exe ; 获取崩坏3游戏窗口参数（同样适用于非全屏）
        MouseMove, Client_Width/2, Client_Height/2, 0 ; [建议保持数值] 使鼠标回正，居中于窗口
    }
}

;【函数 Function】限制光标
Restriction()
{
    If WinActive("ahk_exe BH3.exe")
    {
        MouseGetPos, x1, y1
        If (Toggle_Restriction)
        {
            WinGetPos, ClientUpperLeftCorner_X, ClientUpperLeftCorner_Y, Client_Width, Client_Height, ahk_exe BH3.exe
            If (x1 > (ClientUpperLeftCorner_X + Client_Width / 2 + Client_Width / 4) || x1 < (ClientUpperLeftCorner_X + Client_Width / 2 - Client_Width / 4) || y1 > (ClientUpperLeftCorner_Y + Client_Height / 2 + Client_Height / 4) || y1 < (ClientUpperLeftCorner_Y + Client_Height / 2 - Client_Height / 4))
            {
                If (Status_ViewControl)
                {
                    SendInput, {Click, Up Middle}
                    Status_ViewControl := !Status_ViewControl
                }
                CoordReset()
            }
        }
    }
}

;【函数 Function】视角跟随
ViewControl()
{
    If WinActive("ahk_exe BH3.exe")
    {
        Restriction()
        Sleep, 1 ; [可调校数值 adjustable parameters] 设定采集当前光标坐标值的时间间隔(ms)
        MouseGetPos, x2, y2
        If (x1 != x2 or y1 != y2)
        {
            If (!Status_ViewControl)
            {
                Status_ViewControl := !Status_ViewControl
                SendInput, {Click, Down Middle}
            }
        }
        Else
        {
            If (Status_ViewControl)
            {
                SendInput, {Click, Up Middle}
                Status_ViewControl := !Status_ViewControl
            }
        }
    }
}

;【函数 Function】临时视角跟随
ViewControlTemp()
{
    If WinActive("ahk_exe BH3.exe")
    {
        Threshold := 33 ; [可调校数值 adjustable parameters] 设定切换两种视角跟随模式的像素阈值
        Restriction()
        Sleep, 1 ; [可调校数值 adjustable parameters] 设定采集当前光标坐标值的时间间隔(ms)
        MouseGetPos, x2, y2
        If (abs(x1 - x2) > Threshold or abs(y1 - y2) > Threshold)
        {
            If (!Status_ViewControl)
            {
                Status_ViewControl := !Status_ViewControl
                SendInput, {Click, Down Middle}
            }
        }
        Else If (y1 > y2)
        {
            SendInput, {n Down}
            Sleep, 1
            SendInput, {n Up}
        }
        Else If (y1 < y2)
        {
            SendInput, {m Down}
            Sleep, 1
            SendInput, {m Up}
        }
        Else If (x1 > x2)
        {
            SendInput, {q Down}
            Sleep, 1
            SendInput, {q Up}
        }
        Else If (x1 < x2)
        {
            SendInput, {e Down}
            Sleep, 1
            SendInput, {e Up}
        }
        Else If (x1 > x2 and y1 > y2)
        {
            SendInput, {q Down}{n Down}
            Sleep, 1
            SendInput, {q Up}{n Up}
        }
        Else If (x1 < x2 and y1 > y2)
        {
            SendInput, {e Down}{n Down}
            Sleep, 1
            SendInput, {e Up}{n Up}
        }
        Else If (x1 > x2 and y1 < y2)
        {
            SendInput, {q Down}{m Down}
            Sleep, 1
            SendInput, {q Up}{m Up}
        }
        Else If (x1 < x2 and y1 < y2)
        {
            SendInput, {e Down}{m Down}
            Sleep, 1
            SendInput, {e Up}{m Up}
        }
        Else
        {
            If (Status_ViewControl)
            {
                SendInput, {Click, Up Middle}
                Status_ViewControl := !Status_ViewControl
            }
        }
    }
}

;【函数 Function】准星控制
AimControl()
{
    If WinActive("ahk_exe BH3.exe")
    {
        Loop
        {
            Restriction()
            Sleep, 1 ; [可调校数值 adjustable parameters] 设定采集当前光标坐标值的时间间隔(ms)
            MouseGetPos, x2, y2
            If (x1 != x2 or y1 != y2) ; 采用层级指令覆盖结构
            {
                If (y1 > y2)
                {
                    If (!Status_w)
                    {
                        Status_w := !Status_w
                        SendInput, {w Down}
                    }
                    Else
                    {
                        If (Status_s)
                        {
                            SendInput, {s Up}
                            Status_s := !Status_s
                        }
                        If (Status_a)
                        {
                            SendInput, {a Up}
                            Status_a := !Status_a
                        }
                        If (Status_d)
                        {
                            SendInput, {d Up}
                            Status_d := !Status_d
                        }
                    }
                }
                If (y1 < y2)
                {
                    If (!Status_s)
                    {
                        Status_s := !Status_s
                        SendInput, {s Down}
                    }
                    Else
                    {
                        If (Status_w)
                        {
                            SendInput, {w Up}
                            Status_w := !Status_w
                        }
                        If (Status_a)
                        {
                            SendInput, {a Up}
                            Status_a := !Status_a
                        }
                        If (Status_d)
                        {
                            SendInput, {d Up}
                            Status_d := !Status_d
                        }
                    }
                }
                If (x1 > x2)
                {
                    If (!Status_a)
                    {
                        Status_a := !Status_a
                        SendInput, {a Down}
                    }
                    Else
                    {
                        If (Status_w)
                        {
                            SendInput, {w Up}
                            Status_w := !Status_w
                        }
                        If (Status_s)
                        {
                            SendInput, {s Up}
                            Status_s := !Status_s
                        }
                        If (Status_d)
                        {
                            SendInput, {d Up}
                            Status_d := !Status_d
                        }
                    }
                }
                If (x1 < x2)
                {
                    If (!Status_d)
                    {
                        Status_d := !Status_d
                        SendInput, {d Down}
                    }
                    Else
                    {
                        If (Status_w)
                        {
                            SendInput, {w Up}
                            Status_w := !Status_w
                        }
                        If (Status_s)
                        {
                            SendInput, {s Up}
                            Status_s := !Status_s
                        }
                        If (Status_a)
                        {
                            SendInput, {a Up}
                            Status_a := !Status_a
                        }
                    }
                }
            }
            Else
            {
                If (Status_w)
                {
                    SendInput, {w Up}
                    Status_w := !Status_w
                }
                If (Status_s)
                {
                    SendInput, {s Up}
                    Status_s := !Status_s
                }
                If (Status_a)
                {
                    SendInput, {a Up}
                    Status_a := !Status_a
                }
                If (Status_d)
                {
                    SendInput, {d Up}
                    Status_d := !Status_d
                }
            }
            Sleep, 20 ; [可调校数值 adjustable parameters] 设定准星跟随命令的每执行间隔时间(ms)
            If (BreakFlag_Aim) ; (Abort the function when BreakFlag_Aim == 1)
            {
                BreakFlag_Aim := !BreakFlag_Aim
                break
            }
        }Until Not GetKeyState(A_ThisHotkey, "P")
        If (Status_w)
        {
            SendInput, {w Up}
            Status_w := !Status_w
        }
        If (Status_s)
        {
            SendInput, {s Up}
            Status_s := !Status_s
        }
        If (Status_a)
        {
            SendInput, {a Up}
            Status_a := !Status_a
        }
        If (Status_d)
        {
            SendInput, {d Up}
            Status_d := !Status_d
        }
    }
}

;【函数 Function】输入重置
InputReset()
{
    If GetKeyState(MButton)
    {
        If (Status_ViewControl)
        {
            Status_ViewControl := !Status_ViewControl
        }
        SendInput, {Click, Up Middle}
    }
    SetTimer, ViewControlTemp, Delete
    SetTimer, AimControl, Delete
}

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【函数 Function】自动识别
AutoScale()
{
    If WinActive("ahk_exe BH3.exe")
    {
        WinGetPos, ClientUpperLeftCorner_X, ClientUpperLeftCorner_Y, Client_Width, Client_Height, ahk_exe BH3.exe

        If (Client_Width / Client_Height == 1920 / 1080)
        { ; 默认数值源于1920*1080分辨率下的测试结果
            UpperLeftCorner_X := ClientUpperLeftCorner_X
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(69 * 2 * Client_Width / 1920)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(51 * 2 * Client_Height / 1080)
            LowerRightCorner_X2 := ClientUpperLeftCorner_X + Client_Width
            LowerRightCorner_Y2 := ClientUpperLeftCorner_Y + Client_Height
            UpperLeftCorner_X2 := LowerRightCorner_X2 - Round(69 * 2 * Client_Width / 1920)
            UpperLeftCorner_Y2 := LowerRightCorner_Y2 - Round(51 * 2 * Client_Height / 1080)
            Switch Client_Height
            {
                Case "720": ;[已测试 tested]（颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化100%）
                    Icon := "|<CombatIcon_WithTips_Normal>0xFFFFFF@1.00$72.001U0000001U00600000000s00Q00000000Q00s00000000S01k00000000C03k00000000D07U00000000D07U00000000D0D000000000D0D000000000D0D000000000D0C000000000T0S000000000S0S000000000S0S000000000S0w000000000y0w000000000w0w000000000w0s000000000w1s000000001s1s000000001s1s000000001s1k000000003s3k000000003k3k000000003k3k000000003k3U000000007k7U000000007U7U000000007U70000000007UD000000000DUD000000000D0D000000000D0C000000000T0S000000000T0S000000000S0Q000000000S0Q000000000y0w000000000y0w000000000w0w000000001w0Q000000001s0S000000003k0C000000003k0C000000007U0700000000C003U0000000Q000k0000001k0000007k0000000000400000000000400000000000410E000000007X0U0000000041100000000040l000000000409000000000408U000000007lUQ0000U"
                    Icon .= "|<CombatIcon_WithTips_Endangered>0xE8C8CF@0.81$72.00200000001k00A00000000s00s00000000Q01k00000000S03U00000000D03U00000000D07000000000D07000000000D0C000000000D0C000000000D0C000000000T0C000000000T0Q000000000T0Q000000000y0Q000000000y0s000000000y0s000000000y0s000000001y1s000000001w1s000000001w1k000000003w1k000000003s3U000000003s3U000000003s3U000000007s3U000000007k7U000000007k7000000000Dk6000000000DkC000000000DUC000000000DUC000000000TUC000000000TUA000000000T0Q000000000z0Q000000000z0M000000000z0s000000000y0s000000001y0s000000001y0s000000003w0Q000000003w0Q000000007s0S00000000Ds0C00000000Dk0700000000z003U0000007y001k0000007s000A00Dk007U00000040000000000040000000000043sw00000000Dn1U00000000C3VU00000000A1tU00000000A0NU00000000DkNk00000000Dnkw0000U"
                    Icon .= "|<CombatIcon_WithoutTips_Normal>0xFFFFFF@1.00$72.001U0000001U00600000000s00Q00000000Q00s00000000S01k00000000C03k00000000D07U00000000D07U00000000D0D000000000D0D000000000D0D000000000D0C000000000T0S000000000S0S000000000S0S000000000S0w000000000y0w000000000w0w000000000w0s000000000w1s000000001s1s000000001s1s000000001s1k000000003s3k000000003k3k000000003k3k000000003k3U000000007k7U000000007U7U000000007U70000000007UD000000000DUD000000000D0D000000000D0C000000000T0S000000000T0S000000000S0Q000000000S0Q000000000y0w000000000y0w000000000w0w000000001w0Q000000001s0S000000003k0C000000003k0C000000007U0700000000C003U0000000Q000k0000001k00U"
                    Icon .= "|<CombatIcon_WithoutTips_Endangered>0xF4D0CD@0.81$73.003U0000001k00700000000Q00D00000000700D000000003k0D000000001w07U00000000S07U00000000D03U000000007k3k000000003s1s000000001s0s000000001w0w000000000y0S000000000T0C000000000T0D000000000DU7U000000007k3k000000007s1k000000003s1s000000001w0w000000000y0Q000000000z0C000000000T0D000000000DU7U000000007k3U000000007s1k000000003s1s000000001w0w000000001y0Q000000000z0S000000000T0D000000000DU7000000000Dk3U000000007s3k000000003s1s000000003w0s000000001y0Q000000000z0S000000000T0D000000000TU7U00000000Dk3k00000000Dk1s000000007s0Q000000007s0D000000007s03k00000003w00s00000007s00C00000007s003U000000Dk000A000001zU00E"
                    Icon .= "|<ElysiumIcon_UpperLeft>0xFFFFFF@1.00$15.0080300s0D03s0z0Ds3v0y8DU3s0y0DU3s0y07k0T01w07k0T01w07l0T81z07s0T01s0700M01U"
                    Icon .= "|<ElysiumIcon_LowerRight>0xD4D4D4@1.00$26.0030000k0E0A047zzV00k0E0A04030D00k00zzz0030000k0M0A06631VVUkMMMA6y631jVzzsM006U"

                Case "900": ;[已测试 tested]（颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化100%）
                    Icon := "|<CombatIcon_WithTips_Normal>0xFFFFFF@1.00$89.000U0000000000U00600000000001U00A00000000003000U00000000003U0300000000000700A00000000000D01s00000000000S03k00000000000w07000000000001s0S000000000003k0w000000000007U1s00000000000D03U00000000000S0D000000000001s0S000000000003k0w000000000007U1k00000000000D03000000000000y0C000000000001k0Q000000000003U0s00000000000701U00000000000S07000000000001w0S000000000003k0w000000000007U1k00000000000D03U00000000000y0D000000000001s0S000000000003k0w000000000007U1k00000000000D07U00000000000y0D000000000001s0S000000000003k0s000000000007U1U00000000000T07000000000000w0C000000000001k0Q000000000003U0k00000000000701U00000000000y0D000000000001w0S000000000003k0s000000000007U1k00000000000D03U00000000000y0D000000000001s0S000000000003k0w000000000007U0s00000000000S01k00000000000w03k00000000003U03U0000000000700300000000000Q00200000000001k002000000000040001000000000000000000000000100000000100000000000000200000000000000400000000000000800000000000000E00000000000000U0000000000000100200000000000200400000000000400000000000000800000000000000TU00000004"
                    Icon .= "|<CombatIcon_WithTips_Endangered>0xF0C9C9@0.81$90.000000000000030001U0000000003k003U0000000001s00600000000001w00C00000000000y00Q00000000000y00s00000000000y01s00000000000z01s00000000000z03k00000000000z03k00000000000z03k00000000000z03U00000000000y07U00000000001y07U00000000001y07U00000000001y07000000000003y0C000000000003w0C000000000003w0C000000000003w0S000000000007w0S000000000007s0y000000000007s0y00000000000Ds0w00000000000Ds0s00000000000Dk0s00000000000Dk1s00000000000Tk1s00000000000Tk1s00000000000TU1k00000000000zU3k00000000000zU3U00000000000z03U00000000000z03U00000000001z03U00000000001z03U00000000001z07000000000003y07000000000003y07000000000003y0C000000000003y0C000000000007w0S000000000007w0S00000000000Dw0S00000000000Dw0S00000000000Ds0w00000000000Ds0w00000000000Ds0w00000000000Tk0w00000000000Tk0w00000000000zU0S00000000000zU0S00000000001z00S00000000003z00D00000000007y007U000000000Dw003U000000000zs001k000000003zU000s0007s0007y00002000C00007s0000000040000000000000040000000000000040S7k00000000007kkC000000000007kkA0000000000040QA00000000000406A00000000000403A00000000000603C000000000007sy7k00000U"
                    Icon .= "|<CombatIcon_WithoutTips_Normal>0xFFFFFF@1.00$89.000U0000000000U00600000000001U00A00000000003000U00000000003U0300000000000700A00000000000D01s00000000000S03k00000000000w07000000000001s0S000000000003k0w000000000007U1s00000000000D03U00000000000S0D000000000001s0S000000000003k0w000000000007U1k00000000000D03000000000000y0C000000000001k0Q000000000003U0s00000000000701U00000000000S07000000000001w0S000000000003k0w000000000007U1k00000000000D03U00000000000y0D000000000001s0S000000000003k0w000000000007U1k00000000000D07U00000000000y0D000000000001s0S000000000003k0s000000000007U1U00000000000T07000000000000w0C000000000001k0Q000000000003U0k00000000000701U00000000000y0D000000000001w0S000000000003k0s000000000007U1k00000000000D03U00000000000y0D000000000001s0S000000000003k0w000000000007U0s00000000000S01k00000000000w03k00000000003U03U0000000000700300000000000Q00200000000001k00200000000004000100000000000000000000000010008"
                    Icon .= "|<CombatIcon_WithoutTips_Endangered>0xF1C8C8@0.81$90.000000000000030001U0000000003k007U0000000001s00700000000001w00C00000000000y00Q00000000000y00s00000000000y01s00000000000z01s00000000000z03s00000000000z03k00000000000z03U00000000000z03U00000000000y07U00000000001y07U00000000001y07U00000000001y07000000000003y0D000000000003w0D000000000003w0C000000000003w0S000000000007w0S000000000007s0y00000000000Ds0y00000000000Ds0w00000000000Ds0w00000000000Dk0s00000000000Tk1s00000000000Tk1s00000000000Tk1s00000000000TU1k00000000000zU1k00000000000zU1k00000000000z03U00000000000z03U00000000001z03U00000000001z07U00000000001z07U00000000003y0D000000000003y0D000000000003y0D000000000003y0S000000000007w0S000000000007w0S000000000007w0S00000000000Dw0y00000000000Ds0w00000000000Ds0w00000000000Ds0w00000000000Tk0y00000000000Tk0y00000000000zU0S00000000000zU0S00000000001z00T00000000003z00D00000000007y007U000000000Dw003k000000000Tk001s000000000zU000w000000003y0000600000000Tk000U"
                    Icon .= "|<ElysiumIcon_UpperLeft>0xFFFFFF@1.00$18.00100300300700D00z01z01z03n0710S00w00w01s03U0D00S00S00y00S00D003U03U01s00w00S007107103l01z00z00D00D007003001U"
                    Icon .= "|<ElysiumIcon_LowerRight>0xD4D4D4@1.00$31.000M0000A0300601UDzzkk01U0M00k0A00M0600A0D00600003000Tzzy000k0000M0300A01UE60Uk830EM41U8A20k4610M2T0zzz1U000Y"

                Case "1440": ;[已测试 tested]（颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化81% + [待重测]颜色相似二值化100% + 颜色相似二值化100%）
                    Icon := "|<CombatIcon_WithTips_Normal>0xFFFFFF@1.00$142.0000100000000000000000A00000A00000000000000000k00003000000000000000003k0000A00000000000000000D00003000000000000000000D0000Q000000000000000000w0003k000000000000000003k000T000000000000000000D0003k000000000000000000z000D0000000000000000003w003w000000000000000000Dk00Dk000000000000000000z000w0000000000000000003w003k000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00DU000000000000000000Dk01w0000000000000000003w00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00Dk000000000000000000Dk00z0000000000000000000z003k0000000000000000003w00D0000000000000000000Dk03w0000000000000000003w00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00Dk000000000000000000Dk00y0000000000000000000z003k0000000000000000007w00D0000000000000000000zU03w0000000000000000003w00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00D0000000000000000000Dk00w0000000000000000000z003k000000000000000000Dw00T0000000000000000000zU03w0000000000000000003w00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00D0000000000000000000Dk00w0000000000000000000z007k000000000000000000Ds00z0000000000000000000z003w0000000000000000003w00Dk000000000000000000Dk00y0000000000000000000z003k0000000000000000003w00D0000000000000000000Tk00w0000000000000000003z00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00Dk000000000000000000Dk00w0000000000000000000z003k0000000000000000003w00D0000000000000000000zk00w0000000000000000003z00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00DU000000000000000000Dk00w0000000000000000000z003k0000000000000000003w00D0000000000000000000zk01w0000000000000000003z00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00Dk000000000000000000Dk00D0000000000000000003w000w000000000000000000Dk003k000000000000000000z000D0000000000000000003s000z000000000000000000z0001w000000000000000003w0003k00000000000000000D0000D000000000000000001w0000A00000000000000000D00000s00000000000000000s00000k0000000000000000A00000300000000000000000k000000000000000000000000000000000000DzU000000100000000000000zy0000000000000000000003zs000000000000000000000C00000000000000000000000s00000000000000000000003U0000000000000000000000C00Dk0y00000000000000000s01zUDw00000000000000003U0C21wk0000000000000000Dz1k0D000000000000000000zw7U1s000000000000000003zkS07000000000000000000C00z0Q000000000000000000s01z1k000000000000000003U00y7000000000000000000C000sQ000000000000000000s003ls000000000000000003U00C3k00000000000000000DzVVsDz00000000000000000zy7z0Dw00000000000000003zs7k0DU00000002"
                    Icon .= "|<CombatIcon_WithTips_Endangered>0xEBC8C8@0.81$143.0000000000000000000003k00000000000000000000003k00000400000000000000007s00000M00000000000000007s00003000000000000000007s0000600000000000000000Ds0000k00000000000000000Ts0003U00000000000000000Ts000D000000000000000000zk000y000000000000000001zU003k000000000000000001z0007U000000000000000003z000z0000000000000000007y001y000000000000000000Dw003k000000000000000000Ts007U000000000000000000zk00z0000000000000000003zU01y0000000000000000007z003w000000000000000000Dy007s000000000000000000zw00Dk000000000000000001zs00T0000000000000000003zU01w0000000000000000007z007s000000000000000000Dy00Dk000000000000000000zw00TU000000000000000001zs00z0000000000000000007zU01y000000000000000000Dz003k000000000000000000Ty007U000000000000000000zs00z0000000000000000001zk01y0000000000000000007zU03w000000000000000000Dz007s000000000000000000zy00Dk000000000000000001zs00T0000000000000000003zk00w0000000000000000007zU01s000000000000000000Dz00Dk000000000000000000zw00TU000000000000000001zs00z0000000000000000007zk01y000000000000000000DzU03k000000000000000000Ty007U000000000000000000zw00D0000000000000000001zs00y0000000000000000007zk03w000000000000000000Dz007s000000000000000000zy00Dk000000000000000001zw00TU000000000000000003zs00w0000000000000000007zU01s000000000000000000Dz007k000000000000000000zy00TU000000000000000001zw00z0000000000000000007zk01y000000000000000000DzU03s000000000000000000Tz007U000000000000000000zy00D0000000000000000001zs00S0000000000000000007zk03w000000000000000000DzU07s000000000000000000zz00Dk000000000000000001zw00TU000000000000000003zs00w0000000000000000007zk01s000000000000000000DzU03k000000000000000000zy007U000000000000000001zw00z0000000000000000007zs01y000000000000000000Dzk03w000000000000000000Tz007s000000000000000000zy00Dk000000000000000001zw00S0000000000000000007zk00w000000000000000000DzU03s000000000000000000Tz00Dk000000000000000001zy00TU000000000000000003zs00z0000000000000000007zk01y000000000000000000TzU00y000000000000000000zy001w000000000000000003zw003w000000000000000007zk007s00000000000000000Tz000Dk00000000000000001zy000Tk00000000000000007zs000TU0000000000000000DzU000TU0000000000000000zy0000z00000000000000003zs0000z0000000000000000DzU0000z0000000000000003zy00000z000000000000000Dzk00000T000000000000001zz000000T000000Tz0000007zs0000007000000zy000000Tz00000001U00001zw000000zk00000000000003k0000001w000000000000007U0000000000000000000000D00000000000000000000000S00zk3y00000000000000000w03zUTw00000000000000001s0DX1zs00000000000000003zsS07k000000000000000007zkw0D000000000000000000DzVw0S000000000000000000S03z1s000000000000000000w03z3k000000000000000001s01z7U000000000000000003k00T7U000000000000000007U00SD000000000000000000D000wT000000000000000000TzXbkTy00000000000000000zz7zUTw00000000000000001zyDw0Ds00000000U"
                    Icon .= "|<CombatIcon_WithoutTips_Normal>0xFFFFFF@1.00$142.0000100000000000000000A00000A00000000000000000k00003000000000000000003k0000A00000000000000000D00003000000000000000000D0000Q000000000000000000w0003k000000000000000003k000T000000000000000000D0003k000000000000000000z000D0000000000000000003w003w000000000000000000Dk00Dk000000000000000000z000w0000000000000000003w003k000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00DU000000000000000000Dk01w0000000000000000003w00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00Dk000000000000000000Dk00z0000000000000000000z003k0000000000000000003w00D0000000000000000000Dk03w0000000000000000003w00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00Dk000000000000000000Dk00y0000000000000000000z003k0000000000000000007w00D0000000000000000000zU03w0000000000000000003w00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00D0000000000000000000Dk00w0000000000000000000z003k000000000000000000Dw00T0000000000000000000zU03w0000000000000000003w00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00D0000000000000000000Dk00w0000000000000000000z007k000000000000000000Ds00z0000000000000000000z003w0000000000000000003w00Dk000000000000000000Dk00y0000000000000000000z003k0000000000000000003w00D0000000000000000000Tk00w0000000000000000003z00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00Dk000000000000000000Dk00w0000000000000000000z003k0000000000000000003w00D0000000000000000000zk00w0000000000000000003z00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00DU000000000000000000Dk00w0000000000000000000z003k0000000000000000003w00D0000000000000000000zk01w0000000000000000003z00Dk000000000000000000Dk00z0000000000000000000z003w0000000000000000003w00Dk000000000000000000Dk00D0000000000000000003w000w000000000000000000Dk003k000000000000000000z000D0000000000000000003s000z000000000000000000z0001w000000000000000003w0003k00000000000000000D0000D000000000000000001w0000A00000000000000000D00000s00000000000000000s00000k0000000000000000A00000300000000000000000k0000000000000000000000000000000000000000000001000008"
                    Icon .= "|<CombatIcon_WithoutTips_Endangered>0xEBC8C8@0.81$143.0000000000000000000003k00000000000000000000003k00000400000000000000007s00000M00000000000000007s00003000000000000000007s0000600000000000000000Ds0000k00000000000000000Ts0003U00000000000000000Ts000D000000000000000000zk000y000000000000000001zU003k000000000000000001z0007U000000000000000003z000z0000000000000000007y001y000000000000000000Dw003k000000000000000000Ts007U000000000000000000zk00z0000000000000000003zU01y0000000000000000007z003w000000000000000000Dy007s000000000000000000zw00Dk000000000000000001zs00T0000000000000000003zU01w0000000000000000007z007s000000000000000000Dy00Dk000000000000000000zw00TU000000000000000001zs00z0000000000000000007zU01y000000000000000000Dz003k000000000000000000Ty007U000000000000000000zs00z0000000000000000001zk01y0000000000000000007zU03w000000000000000000Dz007s000000000000000000zy00Dk000000000000000001zs00T0000000000000000003zk00w0000000000000000007zU01s000000000000000000Dz00Dk000000000000000000zw00TU000000000000000001zs00z0000000000000000007zk01y000000000000000000DzU03k000000000000000000Ty007U000000000000000000zw00D0000000000000000001zs00y0000000000000000007zk03w000000000000000000Dz007s000000000000000000zy00Dk000000000000000001zw00TU000000000000000003zs00w0000000000000000007zU01s000000000000000000Dz007k000000000000000000zy00TU000000000000000001zw00z0000000000000000007zk01y000000000000000000DzU03s000000000000000000Tz007U000000000000000000zy00D0000000000000000001zs00S0000000000000000007zk03w000000000000000000DzU07s000000000000000000zz00Dk000000000000000001zw00TU000000000000000003zs00w0000000000000000007zk01s000000000000000000DzU03k000000000000000000zy007U000000000000000001zw00z0000000000000000007zs01y000000000000000000Dzk03w000000000000000000Tz007s000000000000000000zy00Dk000000000000000001zw00S0000000000000000007zk00w000000000000000000DzU03s000000000000000000Tz00Dk000000000000000001zy00TU000000000000000003zs00z0000000000000000007zk01y000000000000000000TzU00y000000000000000000zy001w000000000000000003zw003w000000000000000007zk007s00000000000000000Tz000Dk00000000000000001zy000Tk00000000000000007zs000TU0000000000000000DzU000TU0000000000000000zy0000z00000000000000003zs0000z0000000000000000DzU0000z0000000000000001zy00000z0000000000000007zk00000T000000000000000Tz000000T000000000000003zs000000700000000000000Tz00000001U000000000000Tzk0000000000000000000003k000001"
                    Icon .= "|<ElysiumIcon_UpperLeft>0xFFFFFF@1.00$29.00002000040000s0001k000DU000T0003y0007w000zs001zk00DzU00Tz003wC007sQ00z0801y0E0Dk000TU003w0007s000z0001y000Dk000TU003w0007s000z0001y000Dw000Ts000Dk000TU000Dk000TU000Dk000TU000Dk000TU000Dk000TU000Dk000TU000Dk200TU400Dk800TUE00DzU00Tz000Dy000Tw000Ds000Tk000DU000T0000C0000Q000080000M"
                    Icon .= "|<ElysiumIcon_LowerRight>0xD4D4D4@1.00$52.00000D00000000w00000003k001s000D0007U000w000S0Dzzzzw1s0zzzzzk7U3zzzzz0S0Dzzzzw1s000D0007U000w000S0003k001s000D003zU000w00Dy0003k00zs3zzzzzzzUDzzzzzk00zzzzzz003zzzzzw00000w00000003k000w000D0003k000w000D0DU3k1w0w0y0D07k3k3s0w0T0D0DU3k1w0w0y0D07k3k3s0w0T0D0DU3k1wzw0y0D07nzk3zzzzzDz0Dzzzzwzw0zzzzzk3k00000T0D000001wU"


                Case "2160":
                    Icon := 
                    Icon .= 
                    Icon .= 
                    Icon .= 
                    Icon .= 
                    Icon .= 

                Default: ;[已测试 tested]（颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化100%）
                    Icon := "|<CombatIcon_WithTips_Normal>0xFFFFFF@1.00$106.000400000000000030001U000000000000C00060000000000000s001U0000000000000s00C00000000000003U00s0000000000000C00700000000000000w01w00000000000003k07k0000000000000D00Q00000000000000w03k00000000000003k0D00000000000000D00w00000000000000w03k00000000000003k0C00000000000000T01s00000000000003s0DU0000000000000DU0y00000000000000y03s00000000000003s0D00000000000000DU0s00000000000000y07U00000000000007U0S00000000000000S01s00000000000001s07U00000000000007U0Q00000000000000y03k00000000000007s0T00000000000000T01w00000000000001w07k00000000000007k0Q00000000000000T01k00000000000003w0D00000000000000DU0w00000000000000w03k00000000000003k0D00000000000000D00s00000000000000w07U0000000000000Dk0y00000000000000y03s00000000000003s0D00000000000000DU0s00000000000000y03U00000000000003s0S00000000000000T01s00000000000001s07U00000000000007U0Q00000000000000S01k00000000000001s0700000000000000TU1w00000000000001w07k00000000000007k0S00000000000000T01k00000000000001w07000000000000007k0Q00000000000000z03k00000000000003k0D00000000000000D00w00000000000000w01k0000000000000DU0700000000000000y00Q00000000000003s01w0000000000000S003k0000000000001s00700000000000007000A0000000000001k000k00000000000070000U000000000000U0000U000000000000000000000000000010000000000Dw0000000000000000s00000000000000003U0000000000000000C00000000000000000s0DUT0000000000003U3W7g000000000000DwA0s0000000000000zkk300000000000003U3kQ0000000000000C03lk0000000000000s03b00000000000003U06A0000000000000C00Ms0000000000000zsz1z0000000000003zVk1k000000U"
                    Icon .= "|<CombatIcon_WithTips_Endangered>0xE7C6D0@0.81$108.0000000000000000A00000000000000000D000040000000000007U000M0000000000007k001s0000000000003s003s0000000000003w003k0000000000003w007U0000000000001y00D00000000000001y00D00000000000001y00S00000000000001y00y00000000000001z00y00000000000001z00w00000000000003y00w00000000000003y01s00000000000003y01k00000000000003y03s00000000000003y03s00000000000007w03k00000000000007w03k0000000000000Dw03k0000000000000Ds03U0000000000000Ds07U0000000000000Ds07U0000000000000Ts07U0000000000000Ts07U0000000000000Tk0DU0000000000000zk0D00000000000000zk0D00000000000000zk0T00000000000000zU0S00000000000001zU0S00000000000001zU0y00000000000001z00y00000000000003z00w00000000000003z00w00000000000003z01s00000000000003z01s00000000000007y01k00000000000007y03k00000000000007y03k0000000000000Dy03k0000000000000Dw03k0000000000000Dw07U0000000000000Dw07U0000000000000Ts07U0000000000000Ts07U0000000000000Ts0700000000000000zs0D00000000000000zk0D00000000000000zk0T00000000000000zk0T00000000000001zk0S00000000000001zk0S00000000000001zU0y00000000000003zU0y00000000000003zU0w00000000000003z00w00000000000003z00y00000000000007z00y00000000000007y00S0000000000000Dy00S0000000000000Dw00T0000000000000Ts00T0000000000000zs00DU000000000001zk00DU000000000003zU007k000000000007z0001s00000000000Tw0000w00000000001zs0000S0000Dw00003zU000000000Dy00003w0000000000Dy00003k0000000000C00000000000000000C00000000000000000C07sDk000000000000C0DMzk000000000000DwA0s0000000000000DwC1k0000000000000C0DVk0000000000000C07tk0000000000000C01tk0000000000000C00Rs0000000000000Dy0MwE000000000000DyTsTk000000000000DyDUDk000000U"
                    Icon .= "|<CombatIcon_WithoutTips_Normal>0xFFFFFF@1.00$106.000400000000000030001U000000000000C00060000000000000s001U0000000000000s00C00000000000003U00s0000000000000C00700000000000000w01w00000000000003k07k0000000000000D00Q00000000000000w03k00000000000003k0D00000000000000D00w00000000000000w03k00000000000003k0C00000000000000T01s00000000000003s0DU0000000000000DU0y00000000000000y03s00000000000003s0D00000000000000DU0s00000000000000y07U00000000000007U0S00000000000000S01s00000000000001s07U00000000000007U0Q00000000000000y03k00000000000007s0T00000000000000T01w00000000000001w07k00000000000007k0Q00000000000000T01k00000000000003w0D00000000000000DU0w00000000000000w03k00000000000003k0D00000000000000D00s00000000000000w07U0000000000000Dk0y00000000000000y03s00000000000003s0D00000000000000DU0s00000000000000y03U00000000000003s0S00000000000000T01s00000000000001s07U00000000000007U0Q00000000000000S01k00000000000001s0700000000000000TU1w00000000000001w07k00000000000007k0S00000000000000T01k00000000000001w07000000000000007k0Q00000000000000z03k00000000000003k0D00000000000000D00w00000000000000w01k0000000000000DU0700000000000000y00Q00000000000003s01w0000000000000S003k0000000000001s00700000000000007000A0000000000001k000k00000000000070000U000000000000U0000U000000000000000000000000000010000U"
                    Icon .= "|<CombatIcon_WithoutTips_Endangered>0xEECAC9@0.81$108.0001k00000000000Q00003000000000000D0000C0000000000007U000Q0000000000007k000k0000000000003s001k0000000000003w007U0000000000003w00DU0000000000003y00D00000000000001y00S00000000000001y00S00000000000001z00y00000000000003z00y00000000000003z00w00000000000003y01w00000000000003y01s00000000000003y03s00000000000003y03s00000000000007y03s00000000000007w03s00000000000007w03k0000000000000Dw03k0000000000000Ds07U0000000000000Ds07U0000000000000Ds07U0000000000000Ts07U0000000000000Ts0DU0000000000000Tk0T00000000000000zk0T00000000000000zk0T00000000000000zk0S00000000000001zU0S00000000000001zU0S00000000000001zU0w00000000000001z00w00000000000003z00s00000000000003z00s00000000000003z00s00000000000003z01s00000000000007y03s00000000000007y03k00000000000007y03k0000000000000Dy03k0000000000000Dw03k0000000000000Dw07k0000000000000Dw07U0000000000000Ts07U0000000000000Ts07U0000000000000zs07U0000000000000zs0D00000000000000zs0T00000000000000zk0S00000000000000zk0S00000000000001zk0S00000000000001zk0S00000000000001zU0y00000000000003zU0y00000000000003zU0y00000000000003z00y00000000000007z00y00000000000007z00y0000000000000Dy00y0000000000000Dy00S0000000000000Tw00T0000000000000Ts00T0000000000000zs00DU000000000001zk007U000000000003zU007k000000000007z0003s00000000000Dw0000w00000000000zs0000S00000000003zU000020000000000Dy0000000000000000Tk0000U"
                    Icon .= "|<ElysiumIcon_UpperLeft>0xFFFFFF@1.00$22.0004000k003000w007k00T007w00zk03z00yA07UE0S107k00w003k00y007U00S007k00w003k00z000w003k007k007U00S000y000w003k007k007UE0S100y400zk03z007w007k00T000w000k0030006"
                    Icon .= "|<ElysiumIcon_LowerRight>0xD4D4D4@1.00$39.0000s000007003000s00M0070030DzzzUM1zzzw3000s00M007003000s00M00700z000s0007zzzz00zzzzs0007000000s000007001U00s00A1U70A1UA0s1UA1U70A1UA0s1UA1U70A1UA0s1bw1zzzwzUDzzzUA0000AU"
            }
        }

        Else If (Client_Width / Client_Height == 1360 / 768)
        { ; 默认数值源于1360*768分辨率下的测试结果
            UpperLeftCorner_X := ClientUpperLeftCorner_X
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(48 * 2 * Client_Width / 1360)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(36 * 2 * Client_Height / 768)
            LowerRightCorner_X2 := ClientUpperLeftCorner_X + Client_Width
            LowerRightCorner_Y2 := ClientUpperLeftCorner_Y + Client_Height
            UpperLeftCorner_X2 := LowerRightCorner_X2 - Round(48 * 2 * Client_Width / 1360)
            UpperLeftCorner_Y2 := LowerRightCorner_Y2 - Round(36 * 2 * Client_Height / 768)
            Switch Client_Height
            {
                Case "":

                Default: ;[已测试 tested]（颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化96%）
                    Icon := "|<CombatIcon_WithTips_Normal>0xFFFFFF@1.00$76.000000000000U00U000000003004000000000600k000000000M060000000001k0s000000000703U000000000Q0A0000000001k1k0000000007070000000000Q0M0000000001k3U000000000C0C0000000000s0s0000000003U30000000000C0Q0000000001k1k0000000007070000000000Q0M0000000003k3U000000000C0C0000000000s0s0000000007U30000000000y0Q0000000003k1k000000000D070000000000w0M0000000003k3U000000000S0C0000000001s0k0000000007U30000000000S0Q0000000003k1k000000000D060000000000w0s0000000007k7U000000000S0S0000000001k1k0000000007070000000000w0w0000000003k3k000000000C0D0000000000s0Q000000000701k000000000Q03U000000003U06000000000A008000000001U00E000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000E000002"
                    Icon .= "|<CombatIcon_WithTips_Endangered>0xE8C5CB@0.81$77.001U000000070008000000007U01k000000007U07000000000D00Q000000000D01s000000000S03U000000000y0D0000000001w0Q0000000003s0s000000000Dk1k000000000T070000000000y0C0000000001w0Q0000000003s1s000000000DU3U000000000T070000000000y0C0000000003w0s0000000007s1k000000000DU3U000000000T0D0000000001y0Q0000000003w0s0000000007s1k000000000TU7U000000000z0C0000000001y0Q0000000003s0s000000000Dk3k000000000TU70000000000z0S0000000003w0w0000000007s1s000000000Dk3U000000000TUD0000000001y0S0000000003w0s0000000007s1k000000000Tk7U000000000z0D0000000001y0S0000000007w0w000000000Dk1s000000000zU1s000000001y03k000000007s03U00000000Tk07U00000001z007U0000000Ds003U0000001zU000U0000003w0000000DU00700000000E000000000000U01U0000000010SD0000000003tUk00000000063VU00000000081n0000000000E1a0000000000y360000000001ww700001"
                    Icon .= "|<CombatIcon_WithoutTips_Normal>0xFFFFFF@1.00$76.000000000000U00U000000003004000000000600k000000000M060000000001k0s000000000703U000000000Q0A0000000001k1k0000000007070000000000Q0M0000000001k3U000000000C0C0000000000s0s0000000003U30000000000C0Q0000000001k1k0000000007070000000000Q0M0000000003k3U000000000C0C0000000000s0s0000000007U30000000000y0Q0000000003k1k000000000D070000000000w0M0000000003k3U000000000S0C0000000001s0k0000000007U30000000000S0Q0000000003k1k000000000D060000000000w0s0000000007k7U000000000S0S0000000001k1k0000000007070000000000w0w0000000003k3k000000000C0D0000000000s0Q000000000701k000000000Q03U000000003U06000000000A008000000001U00E00000000800U"
                    Icon .= "|<CombatIcon_WithoutTips_Endangered>0xEECAC7@0.81$77.0000000000030008000000007U01k000000007U07000000000D00Q000000000T00s000000000S03U000000000y0C0000000001w0Q0000000003s0s0000000007k1k000000000T070000000000y0C0000000001w0Q0000000003s0k000000000Dk3U000000000T070000000000y0C0000000003w0s0000000007s1k000000000DU30000000000T060000000001y0Q0000000003w0s0000000007k1k000000000TU3U000000000z0C0000000001y0M0000000003s0k000000000Dk3U000000000TU70000000000z0C0000000003w0s0000000007s1k000000000Dk3U000000000TUD0000000001y0S0000000003w0s000000000Ds1k000000000Tk7U000000000z0D0000000001y0S0000000007w0w000000000Dk1s000000000zU1s000000001y03k000000007s03U00000000Tk03U00000001z003U00000007s00300000000zU00000000007w004"
                    Icon .= "|<ElysiumIcon_UpperLeft>0xFFFFFF@1.00$15.0080100M0701s0T0781k0w0D03k0s0C03U0w03U0C00s07U0S01s07U0C00s03s0D00s0300A"
                    Icon .= "|<ElysiumIcon_LowerRight>0xD4D4D4@0.96$25.00600030401U21zzt00M0U0A0E060M03007zzs00k000M0E0A088614430W21UF10k/Uzzwk006U"
            }
        }

        Else If (Client_Width / Client_Height == 1440 / 900)
        { ; 默认数值源于1440*900分辨率下的测试结果
            UpperLeftCorner_X := ClientUpperLeftCorner_X
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(51 * 2 * Client_Width / 1440)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(39 * 2 * Client_Height / 900)
            LowerRightCorner_X2 := ClientUpperLeftCorner_X + Client_Width
            LowerRightCorner_Y2 := ClientUpperLeftCorner_Y + Client_Height
            UpperLeftCorner_X2 := LowerRightCorner_X2 - Round(51 * 2 * Client_Width / 1440)
            UpperLeftCorner_Y2 := LowerRightCorner_Y2 - Round(39 * 2 * Client_Height / 900)
            Switch Client_Height
            {
                Case "":

                Default: ;[已测试 tested]（颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化99%）
                    Icon := "|<CombatIcon_WithTips_Normal>0xFFFFFF@1.00$80.00200000000020030000000000k01U000000000600k0000000001U0Q0000000000Q060000000000703U0000000001k0k0000000000Q0Q000000000070700000000001k1k0000000000Q0s0000000000C0S00000000003U7U0000000000s1s0000000000C0Q00000000003UD00000000001k3k0000000000Q0w000000000070C00000000003k7U0000000000s1s0000000000C0S00000000003U700000000000s1k0000000000w0w0000000000D0D00000000003k300000000000w1k0000000000T0Q00000000007U700000000001s1U0000000000S0M00000000007UC00000000003k3U0000000000w0k0000000000D0A00000000007k700000000001w1k0000000000Q0M000000000070600000000001k3U0000000000w0s0000000000C0C00000000003U3U0000000001k0M0000000000Q060000000000701k0000000003U0A0000000001k010000000000s008000000000M000000000000000000000000000000000200000000000000000000000000000000000000000000000000000U0000000000000010000000000000E000000000000400000000000000000000000200000000U"
                    Icon .= "|<CombatIcon_WithTips_Endangered>0xEBC9CC@0.81$82.00000000000070004000000000C0030000000000w00M0000000001s01U0000000007k0C0000000000T01k0000000001w0600000000007k0s0000000000T03U0000000001w0A00000000007k1k0000000000z0700000000003w0w0000000000Dk3U0000000000y0C00000000007s1s0000000000TU7U0000000001y0S0000000000Dk1k0000000000z0D00000000003w0s0000000000DU3U0000000001y0C00000000007s0s0000000000TU7U0000000003w0Q0000000000Dk1k0000000000z0600000000003w0s0000000000TU3U0000000001y0C00000000007s0k0000000000zU200000000003w080000000000Dk1U0000000000z0600000000007w0s0000000000TU3U0000000001y0C0000000000Ds0k0000000000zU700000000003y0w0000000000Dk3k0000000001z0D00000000007w0w0000000000zU1s0000000003y07U000000000Tk0C0000000001y00w000000000Dk01k000000001y003k00000000Tk00700000000Dy000C00000000zU0006000T0003k00000001U00000000000040000000000000M3lw0000000001wMC000000000061Uk0000000000M3X0000000000103g0000000000606k0000000000TYlw00002"
                    Icon .= "|<CombatIcon_WithoutTips_Normal>0xFFFFFF@1.00$80.00200000000020030000000000k01U000000000600k0000000001U0Q0000000000Q060000000000703U0000000001k0k0000000000Q0Q000000000070700000000001k1k0000000000Q0s0000000000C0S00000000003U7U0000000000s1s0000000000C0Q00000000003UD00000000001k3k0000000000Q0w000000000070C00000000003k7U0000000000s1s0000000000C0S00000000003U700000000000s1k0000000000w0w0000000000D0D00000000003k300000000000w1k0000000000T0Q00000000007U700000000001s1U0000000000S0M00000000007UC00000000003k3U0000000000w0k0000000000D0A00000000007k700000000001w1k0000000000Q0M000000000070600000000001k3U0000000000w0s0000000000C0C00000000003U3U0000000001k0M0000000000Q060000000000701k0000000003U0A0000000001k010000000000s008000000000M00U"
                    Icon .= "|<CombatIcon_WithoutTips_Endangered>0xF2CECB@0.81$82.00000000000060008000000000C0000000000000w00M0000000003s01U0000000007k0C0000000000T01k0000000001w0600000000007k0M0000000000T03U0000000001w0A00000000007k1k0000000000z0700000000003w0w0000000000Dk3U0000000000y0C00000000007s0s0000000000TU7U0000000001w0Q0000000000Dk1k0000000000z0C00000000003w0s0000000000DU3U0000000001y0600000000007s0M0000000000TU300000000001w040000000000Dk1U0000000000z0+00000000003w0s0000000000TU3U0000000001y0C00000000007s0k0000000000zU300000000003w0M0000000000Dk1U0000000000z0600000000007w0M0000000000TU1U0000000001y0C0000000000Ds1E0000000000zU700000000003y0Q0000000000Dk3U0000000001z0C00000000007w0Q0000000000zU1k0000000003y07U000000000Tk0D0000000001y00Q000000000Dk01k000000003y003U00000000Tk007000000003y000C00000000zU00060000001zk002"
                    Icon .= "|<ElysiumIcon_UpperLeft>0xFFFFFF@1.00$16.00400k0300Q03k0T03w0Qk3V0w07U0S03k0Q03U0Q03k0700C00Q01s03k07U0D00C40QE0z01w03k0D00Q00k01U"
                    Icon .= "|<ElysiumIcon_LowerRight>0xD4D4D4@0.99$26.0020000U10080EDzzY00k10080E020400U000800Tzzk00k000808020210UEUE848421210UHUTzw80018"
            }
        }

        Else If (Client_Width / Client_Height == 1680 / 1050)
        { ; 默认数值源于1680*1050分辨率下的测试结果
            UpperLeftCorner_X := ClientUpperLeftCorner_X
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(60 * 2 * Client_Width / 1680)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(45 * 2 * Client_Height / 1050)
            LowerRightCorner_X2 := ClientUpperLeftCorner_X + Client_Width
            LowerRightCorner_Y2 := ClientUpperLeftCorner_Y + Client_Height
            UpperLeftCorner_X2 := LowerRightCorner_X2 - Round(60 * 2 * Client_Width / 1690)
            UpperLeftCorner_Y2 := LowerRightCorner_Y2 - Round(45 * 2 * Client_Height / 1050)
            Switch Client_Height
            {
                Case "":

                Default: ;[未测试 untested]（颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化81% + 颜色相似二值化100% + 颜色相似二值化100%）
                    Icon := "|<CombatIcon_WithTips_Normal>0xFFFFFF@1.00$95.000E00000000001U003000000000003U006000000000007000M000000000003001k000000000006006000000000000D00Q000000000000S01s000000000000w03U000000000001s0D0000000000003k0S0000000000007U0w000000000000D01k000000000000S07U000000000003k0D0000000000007U0S000000000000D00w000000000000S01U000000000000w070000000000003s0S0000000000007U0w000000000000D01s000000000000S03k000000000000w070000000000003s0S0000000000007U0w000000000000D01s000000000000S03U000000000000w070000000000007k0S000000000000D00w000000000000S01s000000000000w030000000000001s0C0000000000007k0w000000000000D01s000000000000S03U000000000000w070000000000001s0S0000000000007k0w000000000000D01s000000000000S03U000000000000w070000000000007s0C000000000000Dk0w000000000000S01s000000000000w03U000000000001s060000000000003k0Q000000000000DU1s000000000000S03k000000000000w07U000000000001s030000000000007U06000000000000D00D000000000001w00S000000000003k00Q000000000007000M00000000000Q000M00000000001U000E000000000020000000000000000000000000000000000000000200000000000000040000000000000008000000000000000E000000000000000U000000000000001w00000000000000200000000000000040040000000000008008000000000000E040000000000000U000000000000001y008000002"
                    Icon .= "|<CombatIcon_WithTips_Endangered>0xEDC9CA@0.81$96.00000000000000600004000000000070000s00000000003k001U00000000001s003U00000000001w00D000000000001y00T000000000001y00S000000000000y00w000000000000z00w000000000000z01s000000000000z00s000000000001z00k000000000001z00k000000000001y01k000000000001y03k000000000001y03k000000000003y03k000000000003y07U000000000007w070000000000007w0D0000000000007w0D0000000000007w0D000000000000Ds0D000000000000Ds0T000000000000Ds0S000000000000Dk0S000000000000Tk0S000000000000Tk0Q000000000000Tk0Q000000000000TU0w000000000000zU1w000000000000zU1s000000000001zU1s000000000001zU3s000000000001z03k000000000001z03k000000000001z03k000000000003z03U000000000003y03U000000000003y07U000000000007y070000000000007w070000000000007w070000000000007w0D000000000000Dw0D000000000000Ds0C000000000000Ds0S000000000000Ts0S000000000000Ts0Q000000000000Ts0Q000000000000Tk0Q000000000000zk0w000000000000zk0y000000000001zU0S000000000001zU0S000000000003z00T000000000007y00D000000000007y00DU0000000000Dw007U0000000000Ts003k0000000000zk001s000000000Dz0000w000000000Dy000040000z0000Ds000000000z0000T0000000000k000000000000000U000000000000000U3sD000000000000k60Q000000000000z60k000000000000k70k000000000000U3kk000000000000U0sk000000000000k0Mk000000000000s0Mw000000000000zbkTU00000U"
                    Icon .= "|<CombatIcon_WithoutTips_Normal>0xFFFFFF@1.00$95.000E00000000001U003000000000003U006000000000007000M000000000003001k000000000006006000000000000D00Q000000000000S01s000000000000w03U000000000001s0D0000000000003k0S0000000000007U0w000000000000D01k000000000000S07U000000000003k0D0000000000007U0S000000000000D00w000000000000S01U000000000000w070000000000003s0S0000000000007U0w000000000000D01s000000000000S03k000000000000w070000000000003s0S0000000000007U0w000000000000D01s000000000000S03U000000000000w070000000000007k0S000000000000D00w000000000000S01s000000000000w030000000000001s0C0000000000007k0w000000000000D01s000000000000S03U000000000000w070000000000001s0S0000000000007k0w000000000000D01s000000000000S03U000000000000w070000000000007s0C000000000000Dk0w000000000000S01s000000000000w03U000000000001s060000000000003k0Q000000000000DU1s000000000000S03k000000000000w07U000000000001s030000000000007U06000000000000D00D000000000001w00S000000000003k00Q000000000007000M00000000000Q000M00000000001U000E00000000002000U"
                    Icon .= "|<CombatIcon_WithoutTips_Endangered>0xF2CCC7@0.81$96.00000000000000200000000000000070000000000000003k001U00000000003s003000000000001w007000000000001y00C000000000001y00S000000000000y00Q000000000000y00w000000000000z01w000000000000z01s000000000000z00s000000000001z01k000000000001y03k000000000001y03k000000000001y03k000000000003y03k000000000003y03U000000000007w070000000000007w0D0000000000007w070000000000007w0D0000000000007s0C000000000000Ds0C000000000000Ds0S000000000000Dk0Q000000000000Tk0Q000000000000Tk0Q000000000000Tk0Q000000000000TU0w000000000000zU0s000000000000zU0s000000000000zU0s000000000001zU1k000000000001z01k000000000001z03k000000000001z03U000000000003z03U000000000003y07U000000000003y070000000000007y070000000000007w070000000000007w07000000000000Dw0D000000000000Dw0D000000000000Ds0D000000000000Ds0C000000000000Ts0C000000000000Ts0Q000000000000Ts0Q000000000000Tk0Q000000000000zk0y000000000000zk0y000000000001zU0y000000000001zU0S000000000003z00T000000000003y00T000000000007y00D00000000000Dw007U0000000000Ts003k0000000000zk001s0000000001z0000w0000000007y0000C000000000Ts0000100000000Dz0000U"
                    Icon .= "|<ElysiumIcon_UpperLeft>0xFFFFFF@1.00$19.000U00E00s00w00y00T00zU0wE0w00S00w00w00w01w00w00w00w01y00z007U01s00S00D001s00S007U03k00S007U01z00zU07k01s00Q006001U"
                    Icon .= "|<ElysiumIcon_LowerRight>0xD4D4D4@1.00$33.000400000U0600400k01U060zzzUk00U0600400k00U0600407k00U003zzzs000U0000400000U0300400M40U430U40UM40U430U40UM40U4z0zzzUM000A00000Y"
            }
        }

        Else If (Client_Width / Client_Height == 2560 / 1080)
        { ; 默认数值源于2560*1080分辨率下的测试结果
            UpperLeftCorner_X := ClientUpperLeftCorner_X + 30 * Client_Width / 2560
            UpperLeftCorner_Y := ClientUpperLeftCorner_Y
            LowerRightCorner_X := UpperLeftCorner_X + Round(100 * 2 * Client_Width / 2560)
            LowerRightCorner_Y := UpperLeftCorner_Y + Round(51 * 2 * Client_Height / 1080)
            LowerRightCorner_X2 := ClientUpperLeftCorner_X + Client_Width - 30 * Client_Width / 2560
            LowerRightCorner_Y2 := ClientUpperLeftCorner_Y + Client_Height
            UpperLeftCorner_X2 := LowerRightCorner_X2 - Round(100 * 2 * Client_Width / 2560)
            UpperLeftCorner_Y2 := LowerRightCorner_Y2 - Round(51 * 2 * Client_Height / 1080)
            Switch Client_Height
            {
                Case "":

                Default: ;[已测试 tested]（颜色相似二值化100% + 颜色相似二值化90% + 颜色相似二值化100% + 颜色相似二值化90% + [待重测]颜色相似二值化99% + 颜色相似二值化100%）
                    Icon := "|<CombatIcon_WithTips_Normal>0xFFFFFF@1.00$110.00020000000000000M0000U00000000000060000k0000000000001s000s00000000000007000A00000000000001k00700000000000000Q007U00000000000007k01s00000000000001w00y00000000000000T00DU00000000000007k03U00000000000001w03s00000000000000T00y000000000000007k0DU00000000000001w03s00000000000000T00w000000000000007k0C000000000000007k07U00000000000001w01s00000000000000T00S000000000000007k07000000000000001w01k00000000000000T01w00000000000000DU0T000000000000003s07k00000000000000y01w00000000000000DU0S000000000000007s07000000000000003w03k00000000000000y00w00000000000000DU0D000000000000003s03U00000000000000y00s00000000000000DU0S000000000000007k0DU00000000000001w03s00000000000000S00y000000000000007U0C000000000000001s03U00000000000000y01s00000000000000T00S000000000000007k07U00000000000001w01k00000000000000T00Q000000000000007k07000000000000003w07k00000000000000y01w00000000000000D00T000000000000003k07000000000000000w01k00000000000000T00Q00000000000000Dk0D000000000000003s03k00000000000000y00s00000000000000DU0C000000000000003s07U00000000000000y01s00000000000000TU0y000000000000007U0DU00000000000001s03s00000000000000S00S00000000000000T007U00000000000007k00s00000000000001w00D00000000000000y003k0000000000000D000Q00000000000007U00700000000000003s000M0000000000000s00030000000000000k0000k000000000000A00000000000000000000000000000000000000000000003000000000000000000k00000000000000000A000000000000000003000000000000000000k000O0000000000000A080E00000000000003y20800000000000000k0U200000000000000A021U00000000000003008M00000000000000k01200000000000000A00EU00000000000003004400000000000000zkQ0Q0000002"
                    Icon .= "|<CombatIcon_WithTips_Endangered>0xEBC8C8@0.90$110.000000000000000007k00000000000000001w00000000000000000T000000000000000007k00000000000000003w00000000000000001z00000000000000000Tk02000000000000007w07k00000000000001y01w00000000000000T00T00000000000000Dk07k00000000000003w07s00000000000000z01y00000000000000Tk0T000000000000007w07k00000000000001y01w00000000000000zU0z00000000000000Ds0Dk00000000000003y03s00000000000000zU0y00000000000000Ts0TU00000000000007w07s00000000000003y03y00000000000000zU0z00000000000000Ds0Dk00000000000003y03s00000000000001zU0y00000000000000Tk0TU00000000000007w07s00000000000001z03y00000000000000zk0z00000000000000Dw0Dk00000000000003y03w00000000000001zU1z00000000000000Ts0TU00000000000007w07s00000000000001z01y00000000000000zk0z00000000000000Dw0Dk00000000000003y07w00000000000001zU1z00000000000000Ts0TU00000000000007y07s00000000000001zU1y00000000000000zk0zU0000000000000Dw0Ds00000000000003z03w00000000000000zU0z00000000000000Ts0Dk00000000000007y03w00000000000003zU0z00000000000000zk0Ds0000000000000Tw03y00000000000007y00TU0000000000003z007s0000000000000zk01z0000000000000Ts00Dk000000000000Dw001y0000000000007y000Dk000000000003y0001y000000000003z0000Dk00000000003z00000y0000Dw00001z000001s0003z00000y00000000000s00000000000000000C000000000000000003U00000000000000000s0TVz0000000000000C0C0w00000000000003z30C00000000000000zUs700000000000000C0DVk00000000000003U0wQ00000000000000s03b00000000000000C00Nk00000000000003z0CD00000000000000ztz1y0000000000000002020000000U"
                    Icon .= "|<CombatIcon_WithoutTips_Normal>0xFFFFFF@1.00$110.00020000000000000M0000U00000000000060000k0000000000001s000s00000000000007000A00000000000001k00700000000000000Q007U00000000000007k01s00000000000001w00y00000000000000T00DU00000000000007k03U00000000000001w03s00000000000000T00y000000000000007k0DU00000000000001w03s00000000000000T00w000000000000007k0C000000000000007k07U00000000000001w01s00000000000000T00S000000000000007k07000000000000001w01k00000000000000T01w00000000000000DU0T000000000000003s07k00000000000000y01w00000000000000DU0S000000000000007s07000000000000003w03k00000000000000y00w00000000000000DU0D000000000000003s03U00000000000000y00s00000000000000DU0S000000000000007k0DU00000000000001w03s00000000000000S00y000000000000007U0C000000000000001s03U00000000000000y01s00000000000000T00S000000000000007k07U00000000000001w01k00000000000000T00Q000000000000007k07000000000000003w07k00000000000000y01w00000000000000D00T000000000000003k07000000000000000w01k00000000000000T00Q00000000000000Dk0D000000000000003s03k00000000000000y00s00000000000000DU0C000000000000003s07U00000000000000y01s00000000000000TU0y000000000000007U0DU00000000000001s03s00000000000000S00S00000000000000T007U00000000000007k00s00000000000001w00D00000000000000y003k0000000000000D000Q00000000000007U00700000000000003s000M0000000000000s00030000000000000k0000k000000000000A0008"
                    Icon .= "|<CombatIcon_WithoutTips_Endangered>0xEBC8C8@0.90$110.000000000000000007k00000000000000001w00000000000000000T000000000000000007k00000000000000003w00000000000000001z00000000000000000Tk02000000000000007w07k00000000000001y01w00000000000000T00T00000000000000Dk07k00000000000003w07s00000000000000z01y00000000000000Tk0T000000000000007w07k00000000000001y01w00000000000000zU0z00000000000000Ds0Dk00000000000003y03s00000000000000zU0y00000000000000Tk0TU00000000000007w07s00000000000003y03y00000000000000zU0z00000000000000Ds0Dk00000000000003y03s00000000000001zU0y00000000000000Tk0TU00000000000007w07s00000000000001z03y00000000000000zk0z00000000000000Dw0Dk00000000000003y03w00000000000001zU1z00000000000000Tk0TU00000000000007w07s00000000000001z01y00000000000000zk0T00000000000000Dw0Dk00000000000003y07w00000000000001zU1z00000000000000Ts0TU00000000000007y07s00000000000001zU1y00000000000000zk0zU0000000000000Dw0Ds00000000000003y03w00000000000000zU0z00000000000000Ts0Dk00000000000007y03w00000000000003z00z00000000000000zk0Ds0000000000000Tw03y00000000000007y00TU0000000000003z007s0000000000000zU01z0000000000000Ts00Dk000000000000Dw001y0000000000007w000Dk000000000003y0001y000000000003z00007k00000000001z00000y00000000001z000001s0000000003y00008"
                    Icon .= "|<ElysiumIcon_UpperLeft>0xFFFFFF@0.99$22.0004000k003000w007k00T007w00zU03z00yA07UE0S107k00w003k00y007k00S007k00y003k00z000w003k007k007U00S000y001w003k007k007UE0S100y400zk03z007w007k00T000w000k0030006"
                    Icon .= "|<ElysiumIcon_LowerRight>0xD4D4D4@1.00$41.0000C000000Q003000s006001k00A0zzzy0M1zzzw0k00C001U00Q003000s006001k0Dw003U0007zzzz00Dzzzy0000Q000000s000001k006003U00A1U70A0M30C0M0k60Q0k1UA0s1U30M1k3060k3U6Tw1zzzwzs3zzzs0k0000m"
            }
        }

        Else
        { ; 其它比率尚未测试
            ;MsgBox, 4,, 请检查当前是否为全屏模式或支持的分辨率！
            ;ExitApp
        }

        ; ScreenScale
        If (FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, 0.00003, 0.00003, Icon)[1].id == "CombatIcon_WithTips_Normal" || FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, 0.12, 0.12, Icon)[1].id == "CombatIcon_WithTips_Endangered" || FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, 0.00003, 0.00003, Icon)[1].id == "CombatIcon_WithoutTips_Normal" || FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, 0.12, 0.12, Icon)[1].id == "CombatIcon_WithoutTips_Endangered")
        {
            If (!Toggle_ManualSuspend)
            {
                If(A_IsSuspended)
                {
                    Suspend, Off
                    If (!Toggle_MouseFunction)
                    {
                        Toggle_MouseFunction := !Toggle_MouseFunction
                        CoordReset()
                        SetTimer, ViewControl, 10 ; [可调校数值 adjustable parameters] 设定视角跟随命令的每执行时间间隔(ms)
                    }
                }
            }
            If (!Status_CombatIcon)
            {
                Status_CombatIcon := !Status_CombatIcon
                If (!Status_Occlusion)
                    Occlusion(Status_Occlusion := !Status_Occlusion)
            }
        }
        Else
        {
            If (Status_CombatIcon)
            {
                If (Status_Occlusion)
                    Occlusion(Status_Occlusion := !Status_Occlusion)
                Status_CombatIcon := !Status_CombatIcon
            }
            If (!A_IsSuspended)
            {
                Suspend, On
                If (Toggle_MouseFunction)
                {
                    SetTimer, ViewControl, Delete
                    InputReset()
                    Toggle_MouseFunction := !Toggle_MouseFunction
                }
            }
            Else If (!Toggle_ManualSuspend)
            {
                If (FindText(X, Y, UpperLeftCorner_X, UpperLeftCorner_Y, LowerRightCorner_X, LowerRightCorner_Y, 0.01, 0.01, Icon)[1].id == "ElysiumIcon_UpperLeft" && FindText(X, Y, UpperLeftCorner_X2, UpperLeftCorner_Y2, LowerRightCorner_X2, LowerRightCorner_Y2, 0.01, 0.01, Icon)[1].id == "ElysiumIcon_LowerRight")
                {
                    If (!Toggle_MouseFunction)
                    {
                        Toggle_MouseFunction := !Toggle_MouseFunction
                        CoordReset()
                        If (Toggle_Restriction)
                            Toggle_Restriction := !Toggle_Restriction
                        SetTimer, ViewControl, 10 ; [可调校数值 adjustable parameters] 设定视角跟随命令的每执行时间间隔(ms)
                    }
                }
                Else
                {
                    If (Toggle_MouseFunction)
                    {
                        SetTimer, ViewControl, Delete
                        If (!Toggle_Restriction)
                            Toggle_Restriction := !Toggle_Restriction
                        InputReset()
                        Toggle_MouseFunction := !Toggle_MouseFunction
                    }
                }
            }
        }
    }

    Else
    {
        InputReset()
    }
    Return
}

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【命令 Directive】不对以下键盘热键使用钩子（也不要对鼠标热键使用InstallMouseHook）
#UseHook, Off

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【热键 Hotkey】点击自定义键以激活视角跟随
Key_ViewControl:
If GetKeyState(Key_ViewControl, "P") ; 通过行为检测防止被部分函数 Function唤醒
{
    Toggle_MouseFunction := !Toggle_MouseFunction
    If (Toggle_MouseFunction)
    {
        CoordReset()
        SetTimer, ViewControl, 10 ; [可调校数值 adjustable parameters] 设定视角跟随命令的每执行时间间隔(ms)
        ToolTip, 视角跟随已手动激活, 0, 999 ; [可调校数值 adjustable parameters]
        Sleep 999 ; [可调校数值 adjustable parameters]
        ToolTip
    }
    Else
    {
        SetTimer, ViewControl, Delete
        InputReset()
        ToolTip, 视角跟随已手动关闭, 0, 999 ; [可调校数值 adjustable parameters]
        Sleep 999 ; [可调校数值 adjustable parameters]
        ToolTip
    }
}
Return

;【热键 Hotkey】点按自定义键以发动普攻
Key_NormalAttack:
If GetKeyState(Key_NormalAttack, "P") ; 通过行为检测防止被ViewControlTemp函数唤醒
{
    SendInput, {j Down}
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Off
        Loop
        {
            ViewControlTemp()
        }Until Not GetKeyState(A_ThisHotkey, "P")
        SetTimer, ViewControl, On
    }
    Else
        KeyWait, %Key_MainSkill%
    SendInput, {j Up}
}
Return

;【热键 Hotkey】按下自定义键以发动必杀技
Key_MainSkill:
If GetKeyState(Key_MainSkill, "P") ; 通过行为检测防止被ViewControlTemp函数唤醒
{
    SendInput, {i Down}
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Off
        Loop
        {
            ViewControlTemp()
        }Until Not GetKeyState(A_ThisHotkey, "P")
        SetTimer, ViewControl, On
    }
    Else
        KeyWait, %Key_MainSkill%
    SendInput, {i Up}
}
Return

;【热键 Hotkey】按下自定义键以发动武器技/后崩坏书必杀技，长按自定义键进入瞄准模式时可用鼠标键操控准心
Key_SecondSkill:
If GetKeyState(Key_SecondSkill, "P") ; 通过行为检测防止被ViewControlTemp函数唤醒
{
    SendInput, {u Down}
    If (Toggle_MouseFunction)
        AimControl()
    Else
        KeyWait, %Key_SecondSkill%
    SendInput, {u Up}
}
Return

;【热键 Hotkey】按下自定义键以发动人偶技
Key_DollSkill:
SendInput, {l Down}
KeyWait, %Key_DollSkill%
SendInput, {l Up}
Return

;【热键 Hotkey】按下自定义键1以发动闪避/冲刺
Key_Dodging1:
SendInput, {k Down}
KeyWait, %Key_Dodging1%
SendInput, {k Up}
Return

;【热键 Hotkey】按下自定义键2以发动闪避/冲刺
Key_Dodging2:
SendInput, {k Down}
KeyWait, %Key_Dodging1%
SendInput, {k Up}
Return

;【热键 Hotkey】按住键盘左侧ALT以正常使用鼠标左键
LAlt:: ; *!LButton::LButton
SetTimer, LAltTab, 0
Hotkey, %Key_NormalAttack%, Off
If (Toggle_MouseFunction)
{
    SetTimer, ViewControl, Delete
    InputReset()
}
If (Status_Occlusion)
    Occlusion(Status_Occlusion := !Status_Occlusion)
KeyWait, LAlt
SetTimer, LAltTab, Off
Hotkey, %Key_NormalAttack%, On
If (Toggle_MouseFunction)
    SetTimer, ViewControl, On
If (!Status_Occlusion)
    Occlusion(Status_Occlusion := !Status_Occlusion)
Return

;---------------------------------------------------------------------------------------------------------------------------------------------------------------

;【热键 Hotkey】按下自定义键以暂停/启用程序
Key_Suspend:
Suspend, Toggle
Toggle_ManualSuspend := !Toggle_ManualSuspend
If (Toggle_ManualSuspend)
{
    If (Toggle_AutoScale)
    {
        If (Status_CombatIcon)
        {
            If (Status_Occlusion)
                Occlusion(Status_Occlusion := !Status_Occlusion)
            SendEvent, {Esc}
        }
        SetTimer, AutoScale, Delete
        Toggle_AutoScale := !Toggle_AutoScale
    }
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Delete
        If GetKeyState(Key_SecondSkill, "P")
            BreakFlag_Aim := !BreakFlag_Aim
        InputReset()
        Toggle_MouseFunction := !Toggle_MouseFunction
    }
    ToolTip, 暂停中, 0, 999 ; [可调校数值 adjustable parameters]
}
Else
{
    If (!Toggle_AutoScale)
    {
        Toggle_AutoScale := !Toggle_AutoScale
        SetTimer, AutoScale, On
        If (Status_CombatIcon)
        {
            If (!Toggle_MouseFunction)
            {
                Toggle_MouseFunction := !Toggle_MouseFunction
                SetTimer, ViewControl, 10 ; [可调校数值 adjustable parameters] 设定视角跟随命令的每执行时间间隔(ms)
            }
        }
    }
    ToolTip, 已启用, 0, 999 ; [可调校数值 adjustable parameters]
    Sleep 210 ; [可调校数值 adjustable parameters]
    ToolTip
}
Return

;【热键 Hotkey】按下自定义键以重启程序呼出操作说明界面
Key_SurfaceCheck:
If (!A_IsSuspended and !Toggle_ManualSuspend)
{
    Toggle_ManualSuspend := !Toggle_ManualSuspend
    Suspend, On
    If (Toggle_AutoScale)
    {
        If (Status_CombatIcon)
        {
            If (Status_Occlusion)
                Occlusion(Status_Occlusion := !Status_Occlusion)
            SendEvent, {Esc}
        }
        SetTimer, AutoScale, Delete
        Toggle_AutoScale := !Toggle_AutoScale
    }
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Delete
        If GetKeyState(Key_SecondSkill, "P")
            BreakFlag_Aim := !BreakFlag_Aim
        InputReset()
        Toggle_MouseFunction := !Toggle_MouseFunction
    }
}
Reload
Return

;【热键 Hotkey】对Win+Tab快捷键的支持命令
#Tab::
If (!A_IsSuspended and !Toggle_ManualSuspend)
{
    Toggle_ManualSuspend := !Toggle_ManualSuspend
    Suspend, On
    If (Toggle_AutoScale)
    {
        If (Status_CombatIcon)
        {
            If (Status_Occlusion)
                Occlusion(Status_Occlusion := !Status_Occlusion)
            SendEvent, {Esc}
        }
        SetTimer, AutoScale, Delete
        Toggle_AutoScale := !Toggle_AutoScale
    }
    If (Toggle_MouseFunction)
    {
        SetTimer, ViewControl, Delete
        If GetKeyState(Key_SecondSkill, "P")
            BreakFlag_Aim := !BreakFlag_Aim
        InputReset()
        Toggle_MouseFunction := !Toggle_MouseFunction
    }
    ToolTip, 暂停中, 0, 999 ; [可调校数值 adjustable parameters]
    Sleep 99 ; [可调校数值 adjustable parameters]
}
WinSet, AlwaysOnTop, Off, A
SendInput, #{Tab}
Return

;【函数 Function】对Alt+Tab快捷键的支持命令
LAltTab()
{
    If GetKeyState("Tab", "P")
    {
        If (!A_IsSuspended and !Toggle_ManualSuspend)
        {
            Toggle_ManualSuspend := !Toggle_ManualSuspend
            Suspend, On
            If (Toggle_AutoScale)
            {
                If (Status_CombatIcon)
                {
                    If (Status_Occlusion)
                        Occlusion(Status_Occlusion := !Status_Occlusion)
                    SendEvent, {Esc}
                }
                SetTimer, AutoScale, Delete
                Toggle_AutoScale := !Toggle_AutoScale
            }
            If (Toggle_MouseFunction)
            {
                SetTimer, ViewControl, Delete
                If GetKeyState(Key_SecondSkill, "P")
                    BreakFlag_Aim := !BreakFlag_Aim
                InputReset()
                Toggle_MouseFunction := !Toggle_MouseFunction
            }
            ToolTip, 暂停中, 0, 999 ; [可调校数值 adjustable parameters]
            Sleep 99 ; [可调校数值 adjustable parameters]
        }
        WinSet, AlwaysOnTop, Off, A
        SendInput, !{Tab}
    }
    Return
}

;---------------------------------------------------------------------------------------------------------------------------------------------------------------
;目前就这些，可根据需要自行修改
;---------------------------------------------------------------------------------------------------------------------------------------------------------------