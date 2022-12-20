# ---- version 3
output "pvt_subnet_id" {
  value = aws_subnet.po-pvt-subnet[*].id
}
output "pub_subnet_id" {
  value = aws_subnet.po-pub-subnet[*].id
}
output "nat_gateway_id" {
  value = aws_nat_gateway.po-ngw[*].id
}
output "natgw_eip-1"{
  value = aws_eip.po-natgw-eip[*].id
}
output "int_gateway_id" {
  value = aws_internet_gateway.po-igw.id
}

# ----- version 2
/*
#-----Private Subnet IDs
output "pvt_subnet_id-1" {
  value = aws_subnet.po-pvt-subnet-1.id
}
output "pvt_subnet_id-2" {
  value = aws_subnet.po-pvt-subnet-2.id
}
output "pvt_subnet_id-3" {
  value = aws_subnet.po-pvt-subnet-3.id
}

#-----Public Subnet IDs
output "pub_subnet_id-1" {
  value = aws_subnet.po-pub-subnet-1.id
}
output "pub_subnet_id-2" {
  value = aws_subnet.po-pub-subnet-2.id
}
output "pub_subnet_id-3" {
  value = aws_subnet.po-pub-subnet-3.id
}
#-----Nat Gateway IDs
output "nat_gateway_id-1" {
  value = aws_nat_gateway.po-ngw-1.id
}
output "nat_gateway_id-2" {
  value = aws_nat_gateway.po-ngw-2.id
}
output "nat_gateway_id-3" {
  value = aws_nat_gateway.po-ngw-3.id
}
#-----Nat Gateway EIP IDs
output "natgw_eip-1"{
  value = aws_eip.po-natgw-eip-1.id
}
output "natgw_eip-2"{
  value = aws_eip.po-natgw-eip-2.id
}
output "natgw_eip-3"{
  value = aws_eip.po-natgw-eip-3.id
}
#-----Internet Gateway IDs
output "int_gateway_id" {
  value = aws_internet_gateway.po-igw.id
}


# ----- version 1
output "pvt_subnet_id" {
  value = aws_subnet.po-pvt-subnet.id
}
output "pub_subnet_id" {
  value = aws_subnet.po-pub-subnet.id
}
*/