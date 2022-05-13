data "aws_region" "current" {}

data "local_file" "baselineIds" {
    filename = "${path.module}/baselineIds.json"
}

provider "aws" {
    region           = data.aws_region.current.name
    operating_system = var.operating_system
    baseline_id      = var.patch_baseline_id
}

resource "local_file" "baselineIds" {
    content  = ""
    filename = "${path.module}/baselineIds.json"
}

resource "null_resource" "baselineIds" {
    provisioner "local-exec" {
    command = <<EOT
      ${path.module}/_init_.py.py register ${self.triggers.baseline_id} ${self.triggers.operating_system} ${self.triggers.region} >> "${path.module}/baselineIds"
EOT
  }
}

  output "baselineIds" {
      value = local_file.baselineIds.content
  }