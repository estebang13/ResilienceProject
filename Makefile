.PHONY: default
default: help

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: delete
delete: # Delete existing stack
	aws cloudformation delete-stack --stack-name cfn-project-EstebanUCR

.PHONY: installCfnUbuntu
installCfnUbuntu: # Install on Ubuntu CFN to enable modules management
	pip install cloudformation-cli cloudformation-cli-java-plugin cloudformation-cli-go-plugin cloudformation-cli-python-plugin cloudformation-cli-typescript-plugin

.PHONY: submitModules
submitModules: # Submit all the modules to enable it to deploy the entire stack
	cd modules/ai/ && cfn submit --set-default --region us-east-1
	cd modules/apiGateway/ && cfn submit --set-default --region us-east-1
	cd modules/iam/ && cfn submit --set-default --region us-east-1
	cd modules/lambdas/ && cfn submit --set-default --region us-east-1
	cd modules/networking/ && cfn submit --set-default --region us-east-1
	cd modules/amplify/ && cfn submit --set-default --region us-east-1
	cd modules/storage/ && cfn submit --set-default --region us-east-1
	cd modules/cognito/ && cfn submit --set-default --region us-east-1
	cd modules/ai/ && cfn submit --set-default --region us-west-2
	cd modules/apiGateway/ && cfn submit --set-default --region us-west-2
	cd modules/iam/ && cfn submit --set-default --region us-west-2
	cd modules/lambdas/ && cfn submit --set-default --region us-west-2
	cd modules/networking/ && cfn submit --set-default --region us-west-2
	cd modules/amplify/ && cfn submit --set-default --region us-west-2

.PHONY: deployRegions
deployRegions: # Deploy the stack using projectAWS file
	aws cloudformation --region us-east-1 deploy --template-file projectAWSRegions.json --parameter-overrides file://paramsVirginia.json --stack-name cfn-project-EstebanUCR --capabilities CAPABILITY_NAMED_IAM
	aws cloudformation --region us-west-2 deploy --template-file projectAWSRegions.json --parameter-overrides file://paramsOregon.json --stack-name cfn-project-EstebanUCR --capabilities CAPABILITY_NAMED_IAM

.PHONY: deployGlobal
deployGlobal: # Deploy the stack using projectAWS file
	aws cloudformation --region us-east-1 deploy --template-file projectAWSGlobal.json --parameter-overrides file://paramsGlobal.json --stack-name cfn-project-EstebanUCR-Global --capabilities CAPABILITY_NAMED_IAM
