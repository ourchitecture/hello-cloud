import { Command } from "@oclif/core";

import * as which from "which";
import spawn = require("cross-spawn");

const GIT_REMOTE_ORIGIN_NAME = "origin";

export default class GitPullRequest extends Command {
  static description = "create a git pull request";

  static examples = [`$ ourc git pr`];

  static flags = {};

  static args = [];

  static enableJsonFlag = true;

  async run(): Promise<{ url: string }> {
    try {
      await which("git");
    } catch {
      this.error(
        'Could not find "git" command. Please install: https://git-scm.com/downloads.'
      );
    }

    let hasGitTown = false;

    try {
      await which("git-town");
      hasGitTown = true;
    } catch {
      this.log(
        'Missing "git-town" command. Skipping sync. Consider installing: https://www.git-town.com/.'
      );
    }

    if (hasGitTown) {
      this.log("[cli] git-town sync");
      const gitTownSyncResult = spawn.sync(
        "git-town",
        ["sync"],
        this.jsonEnabled() ? undefined : { stdio: "inherit" }
      );

      if (gitTownSyncResult.status !== 0) {
        this.error("Failed to syncronize local repository with remote", {
          exit: 100,
          suggestions: ["Check that you can run `git-town sync`."],
        });
      }
    }

    this.log(`[cli] git remote get-url ${GIT_REMOTE_ORIGIN_NAME}`);
    const gitGetOriginUrlResult = spawn.sync("git", [
      "remote",
      "get-url",
      GIT_REMOTE_ORIGIN_NAME,
    ]);

    if (gitGetOriginUrlResult.status !== 0) {
      this.error(
        `Failed to retrieve the git remote URL for "${GIT_REMOTE_ORIGIN_NAME}".`,
        {
          exit: 100,
          suggestions: ['Check that `git remote` contains "origin"'],
        }
      );
    }

    this.log(gitGetOriginUrlResult.stdout.toString());

    const gitOriginUrl = gitGetOriginUrlResult.stdout.toString().trim();

    this.log("[cli] git branch --show-current");
    const gitCurrentBranchResult = spawn.sync("git", [
      "branch",
      "--show-current",
    ]);

    if (gitCurrentBranchResult.status !== 0) {
      this.error(`Failed to retrieve the current git branch.`, {
        exit: 100,
        suggestions: ["Check that `git branch --show-current` works properly"],
      });
    }

    this.log(gitCurrentBranchResult.stdout.toString());

    const gitCurrentBranchName = gitCurrentBranchResult.stdout
      .toString()
      .trim();

    const beginPullRequestFromCurrentBranchUrl = `${gitOriginUrl}/compare/${gitCurrentBranchName}?expand=1`;

    this.log("Begin your Pull Request (PR):");
    this.log(beginPullRequestFromCurrentBranchUrl);

    return {
      url: beginPullRequestFromCurrentBranchUrl,
    };
  }
}
