data "aws_region" "current" {}

data "local_file" "baselineIds" {
    filename = "${path.module}/baselineReports.json"
    depends_on = [local_file.baselineReports]
}

provider "aws" {}

resource "local_file" "baselineReports" {
    content  = ""
    filename = "${path.module}/baselineReports.json"
}

resource "null_resource" "baselineReports" {
    depends_on = [null_resource.baselineReports]
    triggers = {
        region = data.aws_region.current.name
    }
    provisioner "local-exec" {
    command = "python ${path.module}/_main_.py "
    environment = {
        region = data.aws_region.current.name
        sns = aws_sns_topic.ssm_reports.arn
        file = "${path.module}/baselineReports.json"
    }
  }
}

  output "baselineReports" {
      value = local_file.baselineReports.content
  }