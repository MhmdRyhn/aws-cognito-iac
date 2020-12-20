# Aws Cognito IaC
Terraform (IaC) to configure an AWS Cognito user pool.


## Create The Resources
To apply the configuration run the `buils.sh script`. Make sure that the script has teh executable permission.
- Grant executable permission
```shell script
sudo chmod u+x build.sh
```
- Run the build script
```shell script
./build.sh
```

**Issue:** If the `terraform apply` command is applied two or more consecutive times, the cognito user pool gets 
destroyed every time. This is an open issue when this section in README is added/updated. So, the developers must 
be very careful and keep the issue in mind when updating the user pool settings.
Issue link: https://github.com/hashicorp/terraform-provider-aws/issues/4228 
