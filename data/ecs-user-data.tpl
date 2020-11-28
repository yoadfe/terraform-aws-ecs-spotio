Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version: 1.0

--==BOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
# Set any ECS agent configuration options
echo "ECS_CLUSTER=${ecs_cluster}" >> /etc/ecs/ecs.config
echo "ECS_ENABLE_CONTAINER_METADATA=true" >> /etc/ecs/ecs.config
echo 'ECS_AVAILABLE_LOGGING_DRIVERS=["json-file","awslogs","none","gelf"]' >> /etc/ecs/ecs.config

# Increase Host Ulimit
echo "*   hard  nofile  65535" | tee --append /etc/security/limits.conf
echo "*   soft  nofile  65535" | tee --append /etc/security/limits.conf
echo "root   hard  nofile  65535" | tee --append /etc/security/limits.conf
echo "root   soft  nofile  65535" | tee --append /etc/security/limits.conf

#install the Docker volume plugin
docker plugin install rexray/efs REXRAY_PREEMPT=true EFS_REGION=${region} EFS_SECURITYGROUPS=${efs_security_group} --grant-all-permissions
#restart the ECS agent
stop ecs 
start ecs
--==BOUNDARY==--
