import { Command } from "@oclif/core";

export default class World extends Command {
  static description = "Say hello world";

  static examples = [
    `$ ourc hello world
hello world! (./src/commands/hello/world.ts)
`,
  ];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    this.log("hello worldify! (./src/commands/hello/world.ts)");
  }
}
