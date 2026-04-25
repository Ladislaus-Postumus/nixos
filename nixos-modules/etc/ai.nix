{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    loadModels = [ "qwen2.5-coder:14b" ];
    package = pkgs.ollama-vulkan;
  };
}
