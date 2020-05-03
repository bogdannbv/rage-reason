# rage-reason
A SourceMod plugin that tries to shed some light over sudden player disappearances.

### Prerequisites
* [SourceMod](https://www.sourcemod.net/downloads.php) `^1.10`

### Getting started

Copy the `rage-reason.sp` source file to your SourceMod `scripting` directory.
```bash
$ cp scripting/rage-reason.sp /path/to/your/sourcemod/scripting/rage-reason.sp
```

Inside a terminal, navigate to your `scripting` directory
```bash
$ cd /path/to/your/sourcemod/scripting
```

### Compiling

SourceMod comes bundled with a compiler, so that's what we're going to use in order to compile the plugin.
```bash
$ ./compile.sh rage-reason.sp
```

If everything worked as expected, you should find a `rage-reason.smx` inside the `compiled` subdirectory.
```bash
$ ls -l compiled/ | grep "rage-reason"
```

### Running the plugin

Copy the compiled `rage-reason.smx` plugin to your server's SourceMod `plugins` directory.
```bash
$ cp compiled/rage-reason.smx /path/to/your/sourcemod/plugins
```

Start your server and check if the plugin is loaded.
```bash
sm plugins list
```
