locals {
  network_rules_provided     = var.rule_collections["network_rule_collections"] != null
  application_rules_provided = var.rule_collections["application_rule_collections"] != null
  nat_rules_provided         = var.rule_collections["nat_rule_collections"] != null
}
