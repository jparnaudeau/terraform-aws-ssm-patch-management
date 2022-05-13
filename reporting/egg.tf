data "aws_region" "current" {}
 
 
  triggers = {
    region           = data.aws_region.current.name
    operating_system = var.operating_system
    baseline_id      = var.patch_baseline_id
}


provisioner "local-exec" {
    command = <<EOT
      ${path.module}/main.py register ${self.triggers.baseline_id} ${self.triggers.operating_system} ${self.triggers.region}
EOT
  }