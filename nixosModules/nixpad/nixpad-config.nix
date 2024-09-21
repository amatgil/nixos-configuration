{
  networking.hostName = "nixpad";

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

}

# all these comments are garbage
  # Source: https://serveistic.upc.edu/ca/wifiupc/documentacio/configurar-eduroam-amb-archlinux



  # TODO: double check this
  # source: https://nixos.wiki/wiki/Wpa_supplicant (Eduroam section)
  #
     #phase2="auth=PAP"

  /*
  networking.wireless.enable  = true;
  networking.wireless.userControlled.enable = true;
  networking.networkmanager.unmanaged = ["eduroam"];
  networking.wireless.networks.eduroam = {
    auth = ''
      key_mgmt=WPA-EAP
      pairwise=CCMP
      group=CCMP TKIP
      eap=TTLS
      ca_cert="/etc/nixos/secrets/uni/gd_bundle-g2-g1.crt"
      identity="amat.gil"
      altsubject_match="DNS:triangulum.upc.es"
      phase2="auth=PAP"
      password="${builtins.readFile ../../secrets/uni/uni-pass}"
      anonymous_identity="cat.20210081836@upc.edu"
    '';
  };
*/

#    auth = ''
#     key_mgmt=WPA-EAP
#     eap=PEAP
#     identity="amat.gil"
#     password=${builtins.readFile ../../secrets/uni/uni-pass}
#   '';
