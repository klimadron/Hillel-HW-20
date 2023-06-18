resource "aws_instance" "this" {
  count = var.instance_count
  ami = data.aws_ami.amazonlinux2.id

  user_data = file("${path.module}/userdata.sh")

  instance_type = var.type
  root_block_device {
    volume_size = var.disk_size
    volume_type = var.disk_type
  }
  key_name = var.key_name

  tags = {
    Name = var.instance_count == 1 ? var.name : "${var.name}-${count.index}"
  }

  # <CONDITION> ? <RESULT IF TRUE> : <RESULT IF FALSE>

  vpc_security_group_ids = var.security_group_id != "" ? [var.security_group_id] : null
  iam_instance_profile = var.create_ssm_role == "true" ? aws_iam_instance_profile.HW20-iam-profile[0].name : null

  lifecycle {
    ignore_changes = [ami]
  }
}
resource "aws_iam_role" "HW20-iam-role" {
  count = var.create_ssm_role == "true" ? 1 : 0
  name        = "HW20-ssm-role"
  description = "The role for the developer resources EC2"
  assume_role_policy = <<EOF
  {
  "Statement": {
  "Effect": "Allow",
  "Principal": {"Service": "ec2.amazonaws.com"},
  "Action": "sts:AssumeRole"
  }
  }
  EOF
  tags = {
    stack = "HW20"
  }
  }
  resource "aws_iam_role_policy_attachment" "HW20-ssm-policy" {
    count = var.create_ssm_role == "true" ? 1 : 0
    role       = aws_iam_role.HW20-iam-role[0].name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_instance_profile" "HW20-iam-profile" {
  count = var.create_ssm_role == "true" ? 1 : 0
  name = "ec2_profile"
  role = aws_iam_role.HW20-iam-role[0].name
}