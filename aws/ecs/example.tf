resource "aws_iam_role" "secrethub_demo" {
  name               = "SecretHubDemoECSTaskRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
  description        = "Role for SecretHub demo app"
}

data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_kms_key" "secrethub_auth" {
  description = "KMS key to facilitate SecretHub authentication"
}

data "aws_iam_policy_document" "secrethub_auth" {
  statement {
    actions   = ["kms:Decrypt"]
    resources = [aws_kms_key.secrethub_auth.arn]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "secrethub_auth" {
  name        = "SecretHubAuth"
  description = "Allow SecretHub authentication using KMS"
  policy      = data.aws_iam_policy_document.secrethub_auth.json
}

resource "aws_iam_role_policy_attachment" "secrethub_demo_auth" {
  role       = aws_iam_role.secrethub_demo.name
  policy_arn = aws_iam_policy.secrethub_auth.arn
}

variable "secrethub_username" {
  description = "Your SecretHub username"
}

resource "secrethub_service_aws" "demo_app" {
  repo        = "${var.secrethub_username}/demo"
  role        = aws_iam_role.secrethub_demo.name
  kms_key_arn = aws_kms_key.secrethub_auth.arn
}
resource "secrethub_access_rule" "demo_app" {
  account_name = secrethub_service_aws.demo_app.id
  dir          = "${var.secrethub_username}/demo"
  permission   = "read"
}

resource "aws_ecs_cluster" "secrethub_demo" {
  name = "SecretHubDemoCluster"
}
data "aws_iam_role" "ecs_execution_role" {
  name = "ecsTaskExecutionRole"
}

resource "aws_ecs_task_definition" "secrethub_demo" {
  family                   = "SecretHubDemo"
  cpu                      = "256"
  memory                   = "512"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = data.aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.secrethub_demo.arn
  container_definitions    = jsonencode(local.container_definitions)
}

locals {
  container_definitions = [
    {
      name  = "app"
      image = "secrethub/demo-app"
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        },
      ]
      environment = [
        {
          name  = "SECRETHUB_IDENTITY_PROVIDER"
          value = "aws"
        },
        {
          name  = "DEMO_USERNAME"
          value = "secrethub://${var.secrethub_username}/demo/username"
        },
        {
          name  = "DEMO_PASSWORD"
          value = "secrethub://${var.secrethub_username}/demo/password"
        },
      ]
    },
  ]
}

variable "vpc_id" {}

variable "subnets" {
  type = list(string)
}

resource "aws_ecs_service" "secrethub_demo" {
  name            = "SecretHubDemo"
  cluster         = aws_ecs_cluster.secrethub_demo.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.secrethub_demo.arn

  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.secrethub_demo.id]
    assign_public_ip = true
  }

  desired_count = 1
}

resource "aws_security_group" "secrethub_demo" {
  description = "Allow public access to SecretHub demo app"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
