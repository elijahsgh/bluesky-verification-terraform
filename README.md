# Bluesky Verification with Terraform and GCP

This is a quick example on how to add the verification records needed for bluesky. You could add this to an existing domain or gently poke your DevOps team with it... :)

## Inputs
`actor`
The existing bluesky handle that we want the DID from.

`handle`
The desired verified handle (ie: foo.example.org)

`domain`
The domain we are using for our new verified handle (ie: the "example.org" in foo.example.org)

`cloud_dns_zone`
The name of the cloud DNS zone we are modifying

`project`
GCP project with the managed zone above.

## Usage
`terraform apply` and plug in the values above.
Don't forget to destory if you want to verify with a different domain. :)

Have fun!