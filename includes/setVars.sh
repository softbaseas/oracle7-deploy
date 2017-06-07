#!/bin/bash
# This file is for retrieving all the variables from the user.

function promptValue() {
 read -p "$1""" val
 echo $val
}

function getIP() {
  ip1=$(promptValue "Enter main ip (eth0) (ex: 10.174.234.5): ");
  ip2=$(promptValue "Enter secondary ip (eth1) (ex: 10.0.3.5): ");
  externalIP="$ip1";
  internalIP="$ip2";
}

function getFQDN() {
  domain=$(promptValue "Enter domain name (fx my-domain.tld): ")
  subdomain=$(promptValue "Enter subdomain (fx sub (sub.my-domain.tld)): ")
  fqdn="$subdomain.$domain"
  echo "FQDN = $fqdn";
}
