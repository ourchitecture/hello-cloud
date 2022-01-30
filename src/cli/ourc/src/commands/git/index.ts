import { Command } from "@oclif/core";

import * as which from "which";
import spawn = require("cross-spawn");

export default class Git extends Command {
  static description = "git automation tools";

  static examples = [`$ ourc git`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    try {
      await which("git");
    } catch {
      this.error('Could not find "git" command.');
    }

    try {
      spawn("git", ["--version"], { stdio: "inherit" });
    } catch {
      this.log("ERROR: unexpected error executing git version");
    }
  }
}
