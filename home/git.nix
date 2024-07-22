{ pkgs, lib, ...}:

{
  programs.git = {
    enable = true;
    userName = "Philipp Melzer";
    userEmail = "philipp.melzer2014@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = vim;
        autocrlf = false;
      };
      pull = {
        rebase = true;
      };
    };
  };
}
