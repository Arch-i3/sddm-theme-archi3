# Where is my SDDM theme?

*:eyes: That feeling when your SDDM theme suddenly disappeared...*

The *most minimalistic* and *highly customizable* SDDM theme. Only black screen and password input field. Nothing extra, right? Even when you enter wrong password theme will show only red border around your screen. To login, just type your password and press `<Enter>` key.

# Examples of customization

To install one of these configs, run inside theme directory:

```shell
cp <path to config> theme.conf
```

If config based on image background, also copy image. For example:

```shell
cp example_configurations/tree.conf theme.conf
cp example_configurations/tree.png tree.png
```


# Keymaps

`F2` or `Alt+u` - cycle select next user

`Ctrl+F2` or `Alt+Ctrl+u` - cycle select prev user

`F3` or `Alt+s` - cycle select next session

`Ctrl+F3` or `Alt+Ctrl+s` - cycle select prev session

`F10` - Suspend.

`F11` - Poweroff.

`F12` - Reboot.

`F1` - Show help message.
