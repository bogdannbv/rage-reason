# RageReason
A SourceMod plugin that tries to shed some light over sudden player disappearances.

If a user disconnects in a set amount of time after being killed, the disconnection reason will be set to `RAGE QUIT`.

![chat example](https://i.imgur.com/HZUyGap.png)

### Prerequisites
* [SourceMod](https://www.sourcemod.net/downloads.php) `^1.10`

### Getting started

Copy the `rage-reason.sp` source file to the SourceMod `scripting` directory.
```bash
cp scripting/rage-reason.sp /path/to/sourcemod/scripting/rage-reason.sp
```

Inside a terminal, navigate to the `scripting` directory
```bash
cd /path/to/sourcemod/scripting
```

### Compiling

SourceMod comes bundled with a compiler, so that's what we're going to use in order to compile the plugin.
```bash
./compile.sh rage-reason.sp
```

If everything worked as expected, you should find a `rage-reason.smx` inside the `compiled` subdirectory.
```bash
ls -l compiled/ | grep "rage-reason"
```

### Running the plugin

Copy the compiled `rage-reason.smx` plugin to the server's SourceMod `plugins` directory.
```bash
cp compiled/rage-reason.smx /path/to/sourcemod/plugins
```

Start the server and check if the plugin is loaded.
```bash
sm plugins list
```

### Configuration

After running the plugin for the first time, a `plugin.rage-reason.cfg` file will be generated in the server's sourcemod `cfg` directory. \
Example:
```text
/path/to/server/cstrike/cfg/sourcemod/plugin.rage-reason.cfg
```

In the generated file you'll find two ConVars with their default values.
```text
// Determines if the plugin should be enabled.
// -
// Default: "1"
sm_rage-reason_enabled "1"

// The maximum number of seconds after a player's death to consider the disconnect a rage quit.
// -
// Default: "10"
sm_rage-reason_max_seconds "10"
```
