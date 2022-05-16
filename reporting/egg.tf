data "aws_region" "current" {}

data "local_file" "baselineIds" {
    filename = "${path.module}/baselineIds.json"
}

provider "aws" {}

resource "local_file" "baselineIds" {
    content  = ""
    filename = "${path.module}/baselineIds.json"
}

resource "null_resource" "baselineIds" {
    provisioner "local-exec" {
    command = "${path.module}/_init_.py.py register ${self.triggers.baseline_id} ${self.triggers.region} >> '${path.module}/baselineIds.json'"
  }
}

  output "baselineIds" {
      value = local_file.baselineIds.content
  }