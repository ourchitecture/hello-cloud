oclif-hello-world
=================

oclif example Hello World CLI

[![oclif](https://img.shields.io/badge/cli-oclif-brightgreen.svg)](https://oclif.io)
[![Version](https://img.shields.io/npm/v/oclif-hello-world.svg)](https://npmjs.org/package/oclif-hello-world)
[![CircleCI](https://circleci.com/gh/oclif/hello-world/tree/main.svg?style=shield)](https://circleci.com/gh/oclif/hello-world/tree/main)
[![Downloads/week](https://img.shields.io/npm/dw/oclif-hello-world.svg)](https://npmjs.org/package/oclif-hello-world)
[![License](https://img.shields.io/npm/l/oclif-hello-world.svg)](https://github.com/oclif/hello-world/blob/main/package.json)

<!-- toc -->
* [Usage](#usage)
* [Commands](#commands)
<!-- tocstop -->
# Usage
<!-- usage -->
```sh-session
$ npm install -g @ourchitecture/cli
$ ourc COMMAND
running command...
$ ourc (--version)
@ourchitecture/cli/0.0.0 linux-x64 node-v16.13.2
$ ourc --help [COMMAND]
USAGE
  $ ourc COMMAND
...
```
<!-- usagestop -->
# Commands
<!-- commands -->
* [`ourc hello PERSON`](#ourc-hello-person)
* [`ourc hello world`](#ourc-hello-world)
* [`ourc help [COMMAND]`](#ourc-help-command)
* [`ourc plugins`](#ourc-plugins)
* [`ourc plugins:inspect PLUGIN...`](#ourc-pluginsinspect-plugin)
* [`ourc plugins:install PLUGIN...`](#ourc-pluginsinstall-plugin)
* [`ourc plugins:link PLUGIN`](#ourc-pluginslink-plugin)
* [`ourc plugins:uninstall PLUGIN...`](#ourc-pluginsuninstall-plugin)
* [`ourc plugins update`](#ourc-plugins-update)

## `ourc hello PERSON`

Say hello

```
USAGE
  $ ourc hello [PERSON] -f <value>

ARGUMENTS
  PERSON  Person to say hello to

FLAGS
  -f, --from=<value>  (required) Whom is saying hello

DESCRIPTION
  Say hello

EXAMPLES
  $ oex hello friend --from oclif
  hello friend from oclif! (./src/commands/hello/index.ts)
```

_See code: [dist/commands/hello/index.ts](https://github.com/ourchitecture/hello-world/blob/v0.0.0/dist/commands/hello/index.ts)_

## `ourc hello world`

Say hello world

```
USAGE
  $ ourc hello world

DESCRIPTION
  Say hello world

EXAMPLES
  $ oex hello world
  hello world! (./src/commands/hello/world.ts)
```

## `ourc help [COMMAND]`

Display help for ourc.

```
USAGE
  $ ourc help [COMMAND] [-n]

ARGUMENTS
  COMMAND  Command to show help for.

FLAGS
  -n, --nested-commands  Include all nested commands in the output.

DESCRIPTION
  Display help for ourc.
```

_See code: [@oclif/plugin-help](https://github.com/oclif/plugin-help/blob/v5.1.10/src/commands/help.ts)_

## `ourc plugins`

List installed plugins.

```
USAGE
  $ ourc plugins [--core]

FLAGS
  --core  Show core plugins.

DESCRIPTION
  List installed plugins.

EXAMPLES
  $ ourc plugins
```

_See code: [@oclif/plugin-plugins](https://github.com/oclif/plugin-plugins/blob/v2.0.11/src/commands/plugins/index.ts)_

## `ourc plugins:inspect PLUGIN...`

Displays installation properties of a plugin.

```
USAGE
  $ ourc plugins:inspect PLUGIN...

ARGUMENTS
  PLUGIN  [default: .] Plugin to inspect.

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Displays installation properties of a plugin.

EXAMPLES
  $ ourc plugins:inspect myplugin
```

## `ourc plugins:install PLUGIN...`

Installs a plugin into the CLI.

```
USAGE
  $ ourc plugins:install PLUGIN...

ARGUMENTS
  PLUGIN  Plugin to install.

FLAGS
  -f, --force    Run yarn install with force flag.
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Installs a plugin into the CLI.

  Can be installed from npm or a git url.

  Installation of a user-installed plugin will override a core plugin.

  e.g. If you have a core plugin that has a 'hello' command, installing a user-installed plugin with a 'hello' command
  will override the core plugin implementation. This is useful if a user needs to update core plugin functionality in
  the CLI without the need to patch and update the whole CLI.

ALIASES
  $ ourc plugins add

EXAMPLES
  $ ourc plugins:install myplugin 

  $ ourc plugins:install https://github.com/someuser/someplugin

  $ ourc plugins:install someuser/someplugin
```

## `ourc plugins:link PLUGIN`

Links a plugin into the CLI for development.

```
USAGE
  $ ourc plugins:link PLUGIN

ARGUMENTS
  PATH  [default: .] path to plugin

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Links a plugin into the CLI for development.

  Installation of a linked plugin will override a user-installed or core plugin.

  e.g. If you have a user-installed or core plugin that has a 'hello' command, installing a linked plugin with a 'hello'
  command will override the user-installed or core plugin implementation. This is useful for development work.

EXAMPLES
  $ ourc plugins:link myplugin
```

## `ourc plugins:uninstall PLUGIN...`

Removes a plugin from the CLI.

```
USAGE
  $ ourc plugins:uninstall PLUGIN...

ARGUMENTS
  PLUGIN  plugin to uninstall

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Removes a plugin from the CLI.

ALIASES
  $ ourc plugins unlink
  $ ourc plugins remove
```

## `ourc plugins update`

Update installed plugins.

```
USAGE
  $ ourc plugins update [-h] [-v]

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Update installed plugins.
```
<!-- commandsstop -->
