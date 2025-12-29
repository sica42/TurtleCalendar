## 中文版本

TurtleCalendar(乌龟日历)插件适用于经典魔兽Vanilla(1.12)版本的插件。

本仓库主要是对源仓库中的中文本地化不生效的问题进行了修复，未做其他更改。

> 注意：部分翻译调整基于个人的游戏化和理解习惯，不一定适应所有人的语言习惯。由爱好者贡献，仅用于个人学习交流，请勿用于商业用途。

# 乌龟日历

**版本:** 0.10

显示游戏内所有相关计时器的日历：
- 团队副本锁定时间
- 每日战场
- 暗月马戏团地点
- 副本计时器
- 世界BUFF计时器

其他内容请看下面的英文（感觉没太大必要翻译，懒得弄~）

修改内容：

**0.10**

- 修复原作者的多语言机制根本不会生效的问题
- 修复中文的字体没带导致文字不会显示的问题
- 修复部分文本没有翻译的问题
- 修复一些文本机翻不对的翻译
- 增加标题的本地化
- 增加默认的中文地区的时间格式

# TurtleCalendar
**Version:** 0.9.4
**Game Version:** Turtle WoW (Interface 11200)

Shows you an in-game calendar with all relevant timers:
* Raid lockouts
* Battleground of the day
* Darkmoon Faire location
* Instances lockout timers
* World buffs timers

Use `/turtlecalendar` or `/tc` to toggle calendar, or assign a hotkey in key bindings.

Right click the calendar to adjust the following options:
* Toggle visibility of the different timers.
* Toggle condensed timers
* Toggle date

If you are grouped and group leader does a "Reset all instances" you will have to manually reset the current instance timer. You can do this with `/tc reset`.
If the group leader have TurtleCalendar installed you do not need to do this.

> [!NOTE]
> Reset timers have only been added for european server.
> Nordanaar is 100% correct. Tel`Abim should be correct except Edge of Madness which currently is the same as Nordanaar.
> Reset timers for Ambershire are currently the same as Nordanaar and probably wrong.
> Please post a new issue under Issues if you play on another server and know the reset times.

<img width="1351" height="577" alt="Turtle Calendar" src="https://github.com/user-attachments/assets/e6369d2e-5b78-4df3-b1f4-e0968873019c" />

---

## 🧰 Slash Commands

- `/tc` - Toggle calendar.
- `/tc help` - Show all slash commands. 
- `/tc reset` - Manually reset current instance timer.
- `/tc minimap` - Toggle minimap button.
- `/tc dateformat [format]` - Set date format used when when `Show dates` is on.

The date format uses LUA syntax and the default format is "%d.%m.%Y".
See https://documentation.help/Manuale_LUA/dateformat.htm for details on how to customize the date.

---

## 📦 Installation

Using the Turtle Wow Launcher:

Copy and paste https://github.com/sica42/TurtleCalendar into the launcher.

Manual install:
1. Download or clone the addon into your `Interface\AddOns\` folder.
2. Make sure the folder is named `TurtleCalendar`.
3. Restart WoW.

---

## 📄 License

MIT License — do what you want with it. Credits appreciated but not required.

