locals {
  app_name = "example-app"
  port     = 8080
}

resource "aws_ecs_cluster" "example_app" {
  name = "${local.app_name}"
}

resource "aws_ecs_service" "example_app" {
  name            = "${local.app_name}"
  cluster         = "${aws_ecs_cluster.example_app.id}"
  launch_type     = "FARGATE"
  task_definition = "${aws_ecs_task_definition.example_app.arn}"

  network_configuration {
    subnets          = "${var.subnets}"
    security_groups  = "${list(aws_security_group.example_app.id)}"
    assign_public_ip = true
  }

  desired_count = 1
}

resource "aws_ecs_task_definition" "example_app" {
  cpu                      = "256"
  execution_role_arn       = "${data.aws_iam_role.ecs_execution_role.arn}"
  task_role_arn            = "${aws_iam_role.example_app.arn}"
  family                   = "${local.app_name}"
  memory                   = "512"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  container_definitions    = "${jsonencode(local.container_definitions)}"
}

locals {
  container_definitions = [
    {
      name  = "${local.app_name}"
      image = "secrethub/example-app"

      command = [
        "npm",
        "start",
      ]

      portMappings = [
        {
          containerPort = "${local.port}"
          hostPort      = "${local.port}"
        }
      ]

      environment = [
        {
          name  = "SECRETHUB_VAR_app"
          value = "${var.secrets_repo}/${var.env}"
        },
        {
          name  = "SECRETHUB_IDENTITY_PROVIDER"
          value = "aws"
        },
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = "/ecs/${local.app_name}"
          awslogs-region        = "${var.region}"
          awslogs-stream-prefix = "ecs"
        }
      }
    },
  ]
}

data "aws_iam_role" "ecs_execution_role" {
  name = "ecsTaskExecutionRole"
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

resource "aws_iam_role" "example_app" {
  name               = "${local.app_name}"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_assume_role.json}"
  description        = "Role for ${local.app_name}"
}

resource "aws_security_group" "example_app" {
  description = "${local.app_name}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "${local.port}"
    to_port     = "${local.port}"
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
