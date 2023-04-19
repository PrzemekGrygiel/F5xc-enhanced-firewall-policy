resource "volterra_enhanced_firewall_policy" "efp1" {
  name      = "pan-e-w-simple"
  namespace = "system"

  // One of the arguments from this list "allowed_destinations deny_all denied_sources denied_destinations rule_list allow_all allowed_sources" must be set
  rule_list {
    rules {
        metadata {
            name = "rule1"
        }
        source_prefix_list {
          prefixes = [element(var.f5xc_aws_vpc_prefixes, 0)]
        }
        destination_prefix_list {
          prefixes = [element(var.f5xc_aws_vpc_prefixes, 1)]
        }
        insert_service {
            nfv_service {
              name = var.f5xc_nfv_name
            }
          
        }
    }
  }
}


resource "volterra_enhanced_firewall_policy" "efp2" {
  name      = "pan-e-w-vpc"
  namespace = "system"
  rule_list {
    rules {
        metadata {
            name = "rule1"
        }
        source_aws_vpc_ids {
          vpc_id = [element(var.f5xc_aws_vpc_attachment_ids, 0)]

        }
        destination_aws_vpc_ids {
          vpc_id = [element(var.f5xc_aws_vpc_attachment_ids, 1)]
        }
        insert_service {
            nfv_service {
              name = var.f5xc_nfv_name
            }
          
        }
    }
  }
}

resource "volterra_enhanced_firewall_policy" "efp3" {
  name      = "pan-internet-vip"
  namespace = "system"
  rule_list {
    rules {
        metadata {
            name = "internet-to-ce-vip"
        }
        all_sources = true
        destination_prefix_list {
          prefixes =  [element(var.f5xc_aws_vpc_prefixes, 1)]
        }
        allow = true
    }
    rules {
        metadata {
            name = "rulce-to-spoke-vpc2"
        }
        all_sources = true 
        destination_aws_vpc_ids {
          vpc_id = [element(var.f5xc_aws_vpc_attachment_ids, 1)]
        }          
        applications {
          applications = ["APPLICATION_HTTP"] 
        }
        insert_service {
            nfv_service {
              name = var.f5xc_nfv_name
            }
        }  
    }
  }
}

resource "volterra_enhanced_firewall_policy" "efp4" {
  name      = "pan-spoke-vpc1-to-internet"
  namespace = "system"
  rule_list {
    rules {
        metadata {
            name = "rule1"
        }
        source_aws_vpc_ids {
          vpc_id = [element(var.f5xc_aws_vpc_attachment_ids, 0)]

        }
        destination_prefix_list{
          prefixes =  var.public_ips
        }
        insert_service {
            nfv_service {
              name = var.f5xc_nfv_name
            }
          
        }
    }
  }
}


resource "volterra_enhanced_firewall_policy" "efp5" {
  name      = "pan-spoke-to-remote-ce"
  namespace = "system"
  rule_list {
    rules {
        metadata {
            name = "rule1"
        }
        source_aws_vpc_ids {
          vpc_id = [element(var.f5xc_aws_vpc_attachment_ids, 1)]

        }
        destination_prefix_list{
          prefixes =  var.remote_ips
        }
        insert_service {
            nfv_service {
              name = var.f5xc_nfv_name
            }
          
        }
    }
  }
}