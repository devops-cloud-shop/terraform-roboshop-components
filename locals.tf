locals {
    vpc_id              = data.aws_ssm_parameter.vpc_id.value
    ami_id              = data.aws_ami.prav-devops.id
    common_name_suffix  = "${var.project_name}-${var.environment}"
    sg_id               = data.aws_ssm_parameter.sg_id.value
    tg_port             = "${var.component}" == "frontend" ? 80 : 8080
    health_check_path   = "${var.component}" == "frontend" ? "/" : "/health"
    private_subnet_id   = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
    private_subnet_ids  = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
    backend_alb_listener_arn    = data.aws_ssm_parameter.backend_alb_listener_arn.value
    frontend_alb_listener_arn   = data.aws_ssm_parameter.frontend_alb_listener_arn.value
    listener_arn                = "${var.component}" == "frontend" ? "local.frontend_alb_listerner_arn" : "local.backend_alb_listerner_arn"
    host_context                = "${var.component}" == "frontend" ? ["${var.project_name}-${var.environment}-${var.domain_name}"] : ["${var.component}.backend_alb-${var.environment}-${var.domain_name}"]
    common_tags = {
        Project = var.project_name
        Environment = var.environment
        Terraform = "true"
    }
}