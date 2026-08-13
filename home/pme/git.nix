{
  programs.git = {
    enable = true;

    signing = {
      key = "~/.ssh/github_sk.pub";
      signByDefault = true;
      format = "ssh";
    };

    settings = {
      user = {
        name = "Philipp Melzer";
        email = "philipp.melzer00@proton.me";
      };

      alias = {
        l = "log --oneline --author=\"Philipp Melzer\"";
      };

      init.defaultBranch = "main";
      pull.rebase = true;
      push = {
        default = "simple";
        forceWithLease = true;
        autoSetupRemote = true;
      };
      fetch.prune = true;
      url."git@github.com:".insteadOf = "https://github.com/";
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Philipp Melzer";
        email = "philipp.melzer00@proton.me";
      };

      signing = {
        sign-all = true;
        backend = "ssh";
        key = "~/.ssh/github_sk.pub";
      };

      ui = {
        default-command = "status";
      };
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "github.com" = {
        identityFile = "~/.ssh/github_sk";
        identitiesOnly = true;
      };
    };
  };
}
