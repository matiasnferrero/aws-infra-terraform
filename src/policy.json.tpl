{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowListingOfUserFolder",
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${bucket_name}"
      ],
      "Condition": {
        "StringLike": {
          "s3:prefix": [
            "home/$${aws:username}/*",
            "home/$${aws:username}"
          ]
        }
      }
    },
    {
      "Sid": "AllowAllS3ActionsInUserFolder",
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${bucket_name}/home/$${aws:username}/*"
      ]
    }
  ]
}