# Create Frontend With S3 Bucket

## 00. Create bucket
```bash
#region="us-east-1"
bucket_name=$(echo "web-45623$RANDOM")        # create random bucket name
aws s3api create-bucket --bucket $bucket_name --region $region
```

## 01. Create && Modify bucket policy
```bash
cat << EOF > bucket_policy.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": [
                "arn:aws:s3:::$bucket_name",
                "arn:aws:s3:::$bucket_name/*"
            ]
        }
    ]
}
EOF
aws s3api put-bucket-policy --bucket $bucket_name --policy file://bucket_policy.json
```

# 03. Create && Upload static website
```bash
alb_url=$(aws elbv2 describe-load-balancers --query "LoadBalancers[*].DNSName" --output text)
sed -i "s/___/$alb_url/g" ./files/index.html
aws s3 sync ./files/ s3://$bucket_name/
aws s3 website s3://$bucket_name/ --index-document index.html --error-document error.html
```

# 04. static website url
```bash
echo "website url --->  http://$bucket_name.s3-website-$region.amazonaws.com"
```