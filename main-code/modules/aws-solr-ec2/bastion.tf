resource "aws_instance" "bastion_instance" {
    count = 1
    ami = data.aws_ami.windows.id
    instance_type = var.bastion_vm_instance_type
    subnet_id = var.pub_subnet_id[count.index]
    vpc_security_group_ids = [aws_security_group.bastion_sg[count.index].id]
    key_name = "${element(aws_key_pair.kp_solr_ec2.*.key_name,count.index)}"
    availability_zone = var.availability_zone[count.index]
    tags = {
      Name = var.bastion_instance_name
    }
  root_block_device {
      volume_size = var.bastion_vm_root_volume #30 gb
      volume_type = var.root_volume_type
      delete_on_termination = var.root_vol_delete_on_termination
    #   encrypted   = true
      tags = {
        Name = var.bastion_root_volume_name
      }
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
/*

resource "aws_ebs_volume" "bastion_ebs" {
 count = 1
 availability_zone = var.availability_zone[count.index]
 size              = var.bastion_vm_additional_volume
 tags = {
   Name = var.bastion_additional_volume_name
 }
}


resource "aws_volume_attachment" "bastion_ebs_att" {
 count = 1
 device_name = "/dev/sdh"
 volume_id   = aws_ebs_volume.bastion_ebs[count.index].id
 instance_id = aws_instance.bastion_instance[count.index].id
}
*/
