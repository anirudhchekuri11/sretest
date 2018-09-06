resource "aws_iam_server_certificate" "test_cert" {
  name_prefix      = "example-cert"
  certificate_body =  "${tls_self_signed_cert.ca.cert_pem}"
  private_key      =  "${tls_private_key.ca.private_key_pem}" 

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "ourapp" {
  name                      = "terraform-asg-deployment-example"
  #availability_zones        = ["us-east-1a","us-east-1b"]
  cross_zone_load_balancing = true
  subnets             = ["${aws_subnet.subnet_us_east_1a.id}","${aws_subnet.subnet_us_east_1b.id}"]
  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${aws_iam_server_certificate.test_cert.arn}"
  }

  instances                   = ["${aws_instance.web_server.id}"]
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}
