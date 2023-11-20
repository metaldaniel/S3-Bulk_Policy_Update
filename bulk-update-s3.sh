#!/bin/bash

# List of S3 bucket names
buckets=("bucket_a" "bucket_b" "bucket_c")

# Policy JSON
policy='{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "daniel-allow",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::XXXXX",
                    "arn:aws:iam::XXXXX"
                ]
            },
            "Action": [
                "s3:ListBucket",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::<Bucket_name>",
                "arn:aws:s3:::<Bucket_name>/*"
            ]
        }
    ]
}'

# Loop through each bucket and apply the policy
for bucket in "${buckets[@]}"; do
    policy_for_bucket="${policy//<Bucket_name>/$bucket}"
    aws s3api put-bucket-policy --bucket "$bucket" --policy "$policy_for_bucket"
    aws s3api put-bucket-request-payment --bucket "$bucket" --request-payment-configuration Payer=Requester
done