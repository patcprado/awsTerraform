resource "aws_ecs_service" "bia" {
  name            = "service-bia"
  cluster         = aws_ecs_cluster.cluster-bia.id
  task_definition = aws_ecs_task_definition.bia-web.arn
  desired_count   = 1


// esta ignorando o count, linha 5
  lifecycle {
    ignore_changes = [ desired_count ]
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.bia.name
    base              = 1
    weight            = 100
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent = 100


  depends_on = [aws_lb_target_group.tg-bia]

  load_balancer {
    target_group_arn = aws_lb_target_group.tg-bia.arn
    container_name   = "bia"
    container_port   = 8080
  }
}