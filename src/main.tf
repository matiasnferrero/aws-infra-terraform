provider "aws" {
  profile = "default"
  region  = "us-east-1"

}


 data "template_file" "template_policy_for_matias_and_nicolas" {
   template = file("policy.json.tpl")
   
   vars = {
     bucket_name = "shared-bucket-matias-and-nicolas"
   }
 }


# Create two resources:
# 1. Policy to allow users to see and act on own folder under shared bucket
# 2. Policy attachment (bundles policy and IAM-users)

# Resources that exist from before
# 1. IAM users
# 2. bucket

 resource "aws_iam_policy" "AllowListingOfUserFolder_and_AllowAllS3ActionsInUserFolder" {
   policy = data.template_file.template_policy_for_matias_and_nicolas.rendered
 }


resource "aws_iam_user_policy_attachment" "bundleUsersWithPolicy" {
  for_each    = toset(var.list_users)
  user = each.value
  policy_arn = aws_iam_policy.AllowListingOfUserFolder_and_AllowAllS3ActionsInUserFolder.arn
}