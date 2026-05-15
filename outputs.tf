output "web_ap_south_1_public_ip" {
  value = aws_instance.web_ap_south_1.public_ip
  description = "Public IP of the EC2 instance in ap-south-1"
}

output "web_ap_south_2_public_ip" {
  value = aws_instance.web_ap_south_2.public_ip
  description = "Public IP of the EC2 instance in ap-south-2"
}
