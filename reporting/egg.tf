data "aws_region" "current" {}

data "local_file" "baselineIds" {
    filename = "${path.module}/baselineIds.json"
    depends_on = [local_file.baselineIds]
}

provider "aws" {}

resource "local_file" "baselineIds" {
    content  = ""
    filename = "${path.module}/baselineIds.json"
    depends_on = [null_resource.baselineIds]
}

resource "null_resource" "baselineIds" {
    triggers = {
        region = data.aws_region.current.name
    }
    provisioner "local-exec" {
    command = "python ${path.module}/_main_.py register ${self.triggers.region} >> '${path.module}/baselineIds.json'"
  }
}

  output "baselineIds" {
      value = local_file.baselineIds.content
  }