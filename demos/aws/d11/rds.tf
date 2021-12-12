resource "aws_db_parameter_group" "mariadb-parameters" {
  name        = "mariadb-parameters"
  family      = "mariadb10.5"
  description = "MariaDB parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_subnet_group" "mariadb-subnet" {
  name        = "mariadb-subnet"
  description = "RDS subnet group"
  subnet_ids  = ["${aws_subnet.main-private-1.id}", "${aws_subnet.main-private-2.id}"]
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_db_instance" "mariadb" {
  allocated_storage       = 10
  engine                  = "mariadb"
  engine_version          = "10.5.12"
  instance_class          = "db.t2.micro"
  identifier              = "mariadb"
  name                    = "mariadb"
  username                = "root"
  password                = random_password.password.result
  db_subnet_group_name    = aws_db_subnet_group.mariadb-subnet.name
  parameter_group_name    = aws_db_parameter_group.mariadb-parameters.name
  multi_az                = "false"
  vpc_security_group_ids  = ["${aws_security_group.sgAllowMariaDB.id}"]
  storage_type            = "gp2"
  backup_retention_period = 30
  availability_zone       = aws_subnet.main-private-1.availability_zone
  skip_final_snapshot     = true
  //final_snapshot_identifier = "mariadb-final-snapshot"
  tags = {
    Name = "mariadb-instance"
  }
}

output "rds" {
  value = aws_db_instance.mariadb.endpoint
}

output "mysql-password" {
  sensitive = true
  value     = random_password.password.result
}