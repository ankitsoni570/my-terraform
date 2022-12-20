/*
resource "aws_instance" "solr_instance_standalone" {
     count = var.solr_vm_count == 1 ? 1 : 0
     ami = data.aws_ami.windows.id
     instance_type = var.solr_vm_instance_type
     subnet_id = var.pub_subnet_id[count.index]
     vpc_security_group_ids = [aws_security_group.solr_ec2_sg.id]
     key_name = "${element(aws_key_pair.kp_solr_ec2.*.key_name,count.index)}"
     availability_zone = var.availability_zone[count.index]

     root_block_device {
         volume_size = var.solr_vm_root_volume # in GB <<----- I increased this!
         volume_type = "gp3"
         delete_on_termination = true
       #   encrypted   = true
       tags = {
         Name = var.solr_root_volume_name
       }
     }
     tags = {
       Name = var.solr_instance_name
     }
     user_data     = <<EOF
     <powershell>
     Get-Disk |
     Where partitionstyle -eq ‘raw’ |
     Initialize-Disk -PartitionStyle MBR -PassThru |
     New-Partition -AssignDriveLetter -UseMaximumSize |
     Format-Volume -FileSystem NTFS -NewFileSystemLabel “Local Disk” -Confirm:$false
     </powershell>
     <persist>true</persist>
 EOF
   }


resource "aws_ebs_volume" "solr_ec2_standalone_extra" {
  count = var.solr_vm_count == 1 ? 1 : 0
  availability_zone = var.availability_zone[count.index]
  size              = var.solr_vm_additional_volume
  tags = {
    Name = var.solr_additional_volume_name
  }
}


resource "aws_volume_attachment" "standalone_ebs_att" {
  count = var.solr_vm_count == 1 ? 1 : 0
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.solr_ec2_standalone_extra[count.index].id
  instance_id = aws_instance.solr_instance_standalone[count.index].id
}
*/