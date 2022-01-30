import { Command } from "@oclif/core";

import * as which from "which";
import spawn = require("cross-spawn");

export default class GitSync extends Command {
  static description = "syncronize the local git repo with the remote";

  static examples = [`$ ourc git sync`];

  static flags = {};

  static args = [];

  static enableJsonFlag = false;

  async run(): Promise<void> {
    try {
      await which("git-town");
    } catch {
      this.error(
        'Could not find "git-town" command. Please install: https://www.git-town.com/.'
      );
    }

    this.log("[cli] git-town sync");
    spawn.sync("git-town", ["sync"], {
      stdio: "inherit",
    });
  }
}
