{ pkgs, ... }: {
  services.minecraft-server = {
    enable = true;
    eula = true;
    package = pkgs.minecraftServers.vanilla-1-20;
    openFirewall = true;
    declarative = true;
    jvmOpts = "-Xms4G -Xmx8G";
    serverProperties = {
      motd = "XC? More like, no gràcies";
      online-mode=false;
    };
  };
}
