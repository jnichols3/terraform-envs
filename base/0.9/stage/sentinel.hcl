policy "enforce-mandatory-tags" {
    source = "../sentinel/enforce-mandatory-tags.sentinel"
    enforcement_level = "hard-mandatory"
}
policy "restrict-allowed-vm-types" {
    source = "../sentinel/restrict-allowed-vm-types.sentinel"
    enforcement_level = "soft-mandatory"
}
policy "aws-cis-4.1-networking-deny-public-ssh-acl-rules" {
  # (networking outside AWS to get Raw files in GitHub):
  source            = "https://raw.githubusercontent.com/hashicorp/terraform-foundational-policies-library/master/cis/aws/networking/aws-cis-4.1-networking-deny-public-ssh-acl-rules/aws-cis-4.1-networking-deny-public-ssh-acl-rules.sentinel"
  enforcement_level = "soft-mandatory"
}
