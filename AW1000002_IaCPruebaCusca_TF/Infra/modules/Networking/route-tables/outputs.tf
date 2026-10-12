
output "private_route_table_ids" {
  description = "IDs de las tablas de ruteo privadas creadas para la VPC."
  value       = [aws_route_table.rt_private.id]
}

output "public_route_table_id" {
  description = "ID de la tabla de ruteo pública creada para la VPC."
  value       = aws_route_table.rt_public.id
}
