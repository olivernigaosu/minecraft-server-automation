output "public_ip" {
  description = "Public IP of the Minecraft EC2 instance"
  value       = aws_instance.minecraft.public_ip
}
