locals {
    SG = var.INTERNAL ? [aws_security_group.alb_private.id] : [aws_security_group.alb_public.id]
    SUBNET_IDS = var.INTERNAL ? [data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS] : [data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_IDS]
}