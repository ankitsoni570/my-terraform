resource "aws_instance" "agent_machine" {
   count = var.blr_agent_count
   ami = var.blr_agent_ami
   instance_type = var.blr_agent_instance_type
   subnet_id = "subnet-0ea9d58c51993d551"
   vpc_security_group_ids = [aws_security_group.agent-sg.id]
   key_name = "${element(aws_key_pair.kp_bnr_agent.*.key_name,count.index)}" # aws_key_pair.kp_bnr_agent.key_name
#    user_data = "${file("./modules/aws-agent-ec2/requirements.ps1")}"
   user_data     = <<EOF
        <powershell>
        # Installing docker compose
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest "https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\Docker\docker-compose.exe
        $env:Path += ";C:\Program Files\Docker-compose"
        Get-ChildItem $Env:ProgramFiles\Docker-compose

        # Installing AWS CLI
        $dlurl = "https://s3.amazonaws.com/aws-cli/AWSCLI64PY3.msi"
        $installerPath = Join-Path $env:TEMP (Split-Path $dlurl -Leaf)
        Invoke-WebRequest $dlurl -OutFile $installerPath
        Start-Process -FilePath msiexec -Args "/i $installerPath /passive" -Verb RunAs -Wait
        Remove-Item $installerPath
        $env:Path += ";C:\Program Files\Amazon\AWSCLI\bin"
        aws --version
        </powershell>
        <persist>true</persist>
    EOF
   tags = {
      Name = "BnR-win-agent-${count.index}"
    }
    root_block_device {
        volume_size = 128 # in GB <<----- I increased this!
      #   volume_type = "gp3"
      #   encrypted   = true
      #   kms_key_id  = data.aws_kms_key.customer_master_key.arn
    }
}