#!/bin/bash
yum update -y
yum install -y aws-cli httpd jq

systemctl enable httpd
systemctl start httpd

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/local-ipv4)

echo "<h1>Mensaje del Servidor Web</h1>" > /var/www/html/index.html
echo "<p>This message was generated on instance $INSTANCE_ID with the following IP: $PRIVATE_IP</p>" >> /var/www/html/index.html
echo "<p>Web Server is Running!</p>" >> /var/www/html/index.html


BUCKET_NAME="${bucket_name}" 

echo "Instance ID: $INSTANCE_ID | Private IP: $PRIVATE_IP | Timestamp: $(date +%F_%T)" > /tmp/instance_info.txt

/usr/bin/aws s3 cp /tmp/instance_info.txt "s3://$BUCKET_NAME/instance-logs/$INSTANCE_ID.txt"