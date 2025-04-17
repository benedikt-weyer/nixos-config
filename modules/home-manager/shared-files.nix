{
  ...
}:
{
  home.file = {
    ".ssh/config_source" = {
        source = ../../modules/config-files/ssh-config;
        onChange = "cat ~/.ssh/config_source > ~/.ssh/config && chmod 600 ~/.ssh/config";
    };
  };
}
