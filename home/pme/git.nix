{
  programs.git = {
    enable = true;

    signing = {
      key = "~/.ssh/id_ed25519_sk_rk.pub";
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
        behaviour = "drop";
        backend = "ssh";
        key = "~/.ssh/id_ed25519_sk_rk.pub";
      };

      git = {
        sign-on-push = true;
      };

      ui = {
        default-command = "status";
      };

      revsets = {
        log = "latest(::, 10) | present(@) | ancestors(immutable_heads().., 2) | present(trunk())";
      };

      templates = {
        log = "builtin_log_oneline";
      };

      template-aliases = {
        # author: print nothing if it's my own email, otherwise the email
        "format_short_signature_oneline(signature)" = ''if(signature.email() == config("user.email").as_string(), "", signature.email())'';

        # commit hash: print nothing
        "format_short_commit_id(id)" = ''""'';

        # no timestamp by default
        "format_timestamp(timestamp)" = ''""'';
      };

      aliases = {
        e = [
          "edit"
        ];

        b = ["util" "exec" "--" "bash" "-c" "jj bookmark set \"\${1:-main}\" -r @-" ""];

        l = [
          "log"
        ];

        ll = [
          "log"
          "-T builtin_log_compact"
          "--config"
          "template-aliases.\"format_timestamp(timestamp)\"='timestamp.local().format(\"%Y-%m-%d %H:%M:%S\")'"
          "--config"
          "template-aliases.\"format_short_commit_id(id)\"='id.shortest(8)'"
        ];
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

      "raspi" = {
        hostname = "raspi";
        user = "pme";
        identityFile = "~/.ssh/id_ed25519_sk_rk";
        identitiesOnly = true;
        controlMaster = "auto";
        controlPath = "~/.ssh/cm-%r@%h:%p";
        controlPersist = "10m";
      };
    };
  };
}
