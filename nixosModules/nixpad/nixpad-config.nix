{
  networking.hostName = "nixpad";

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  # Source: https://serveistic.upc.edu/ca/wifiupc/documentacio/configurar-eduroam-amb-archlinux



  # TODO: double check this
  # source: https://nixos.wiki/wiki/Wpa_supplicant (Eduroam section)
  #
     #phase2="auth=PAP"

  networking.wireless.enable  = true;
  networking.wireless.userControlled.enable = true;
  networking.networkmanager.unmanaged = ["eduroam"];
  networking.wireless.networks.eduroam = {
     key_mgmt=WPA-EAP;
     eap=TTLS;
     group=CCMP;
     phase2="auth=MSCHAPV2";
     anonymous_identity="anonymous@upc.edu";
     identity="amat.gil";
     password="${builtins.readFile ../../secrets/uni/uni-pass}";
     ca_cert="/etc/nixos/secrets/uni/gd_bundle-g2-g1.crt";
     domain="triangulum.upc.es";
     priority=10;
  };

}

#    auth = ''
#     key_mgmt=WPA-EAP
#     eap=PWD
#     identity="amat.gil"
#     password=${builtins.readFile ../../secrets/uni/uni-pass}
#   '';
