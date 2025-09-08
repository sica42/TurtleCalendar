# TurtleCalendar
**Version:** 0.4
**Game Version:** Turtle WoW (Interface 11200)

Shows you an in-game calendar with all relevant timers:
* Raid lockouts
* Battleground of the day
* Darkmoon Faire location
* Instances lockout timers

Use `/turtlecalendar` or `/tc` to toggle calendar, or assign a hotkey in key bindings.

Right click the calendar to toggle the visibility of the different timers. You can also toggle dates on/off in the right click menu.

If you are grouped and group leader does a "Reset all instances" you will have to manually reset the current instance timer. You can do this with `/tc reset`.
If the group leader have TurtleCalendar installed you do not need to do this.

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

