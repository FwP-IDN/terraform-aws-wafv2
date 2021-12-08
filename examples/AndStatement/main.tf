provider "aws" { region = "ap-northeast-2" }

module "wafv2" {
  source  = "../.."
  name    = "WebACL01"
  scope   = "REGIONAL"

  rules = [
    {
      name                          = "AndRule01"
      priority                      = 10
      action                        = "count"
      and_statement = {
        statements = [
          {
            geo_match_statement = {
              country_codes = ["AF"]
            }
          },
          {
            ip_set_reference_statement = {
              arn = ""
            }
          }
        ]
      }
      visibility_config = {
        cloudwatch_metrics_enabled = false
        metric_name                = "cloudwatch_wafv2_metrics"
        sampled_requests_enabled   = false
      }
    }
  ]

  visibility_config = {
    cloudwatch_metrics_enabled = false
    metric_name                = "cloudwatch_wafv2_metrics"
    sampled_requests_enabled   = false
  }

  tags = {
    "Name": "PROD.WAFv2"
    "Team": "Security Engineering"
    "Owner": "Donggyu Woo"
  }
}