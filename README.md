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
**Limitations:** Under `MFA and verifications`, there is an option **How will a user be able to recover their account?**. 
Configuring this option is not supported in terraform (at the time of writing the configurations). So, you need to set 
this manually to `Email if available, otherwise phone, but don’t allow a user to reset their password via phone if they 
are also using it for MFA` after applying the configurations successfully. An 
[issue](https://github.com/terraform-providers/terraform-provider-aws/issues/11220) has been raised in **GitHub** 
regarding this and it's still open. 

**Warning:** Don't use `provisioner "local-exec"{}` of terraform to set account recovery mechanism. It'll wipe out the 
whole configuration.
