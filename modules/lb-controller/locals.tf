locals {
  oidc = split("/", var.oidc_issuer_url)[4]
}
