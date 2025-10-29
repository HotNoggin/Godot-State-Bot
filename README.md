<div align="center">
 <h1>Godot State Bot</h1>
 <img width="128" height="128" alt="state_bot_icon" src="https://github.com/user-attachments/assets/ac4753dc-2f55-4f02-8c44-b845c1908da0" />
 <p>A versatile, easy to use finite state machine addon for Godot 4</p>
</div>

---

Godot State Bot is a simple implementation of a finite state machine that aims to be extendable and easy to use, while saving you the headache of re-implementing one of the most popular coding patterns in game development.

## Installation

Download the [addons folder](/Project/addons) and copy it into your project. That's it!

## How to Use

TL;DR: Take a look at the example scene in this project.

This addon adds two new nodes:

* **StateBot**, which is the state machine that holds a number of SimpleState descendants and manages them
* **SimpleState**: The states that are managed by the StateBot

Add a StateBot to your scene and set the **puppet** in the inspector. This is the object this StateBot will control (your player, enemy, etc). You can also set your starting state here.

In the inspector, there is a button to create a new SimpleState. Pressing it will add a new SimpleState child and attach a copy of the `simple_state_template.gd` script. Open the newly created script, then go to `File -> Save As...` in order to save it into a new script, or just press `CTRL+S` to save it as a built-in script in the scene. Feel free to adjust the template script to suit your needs.

The SimpleState template script includes four functions by default:

* **_enter_state** - which runs once when this state is entered
* **_exit_state** - which runs once when this state is exited
* **_state_process** - which runs every frame (only when this state is active)
* **_state_physics_process** - which runs every physics frame (only when this state is active)

Inside your SimpleState script, you can use the `state_bot` variable to get the StateBot that manages this state, and use `state_bot.puppet` to get the puppet. Switch states using `state_bot.switch_to_state("StateName")`, where StateName is the name of the SimpleState node.

SimpleStates also have an optional `next_state` variable, which is useful for transitional states that are expected to move to another specific state. For example, a "Heavy Attack Charging" state can have "Heavy Attack" as its next state, since it will always move to that state once it's complete. You can use `switch_to_next()` to easily switch to the next state, or `get_next()` to get the next state.
