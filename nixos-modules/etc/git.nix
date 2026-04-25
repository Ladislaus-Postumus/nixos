{ ... }:
{
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Philipp Melzer";
        email = "philipp.melzer00@proton.me";
        signingkey = "/home/pme/.ssh/github_sk.pub";
      };

      commit.gpgsign = true;
      gpg.format = "ssh";

      init.defaultBranch = "main";

      pull.rebase = true;
      push = {
        default = "simple";
        forceWithLease = true;
        autoSetupRemote = true;
      };

      fetch.prune = true;

      url."git@github.com:".insteadOf = "https://github.com/";

      aliases = {
        l = "log --oneline --author=\"Philpp Melzer\"";
      };
    };
  };
}
