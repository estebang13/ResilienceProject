Follow makefile commands. 

For more information check make help

Submit Modules and Deploy is gonna take a lot of minutes. Be patience please 



Old Commands

aws cloudformation deploy --template-file /home/admin1/Desktop/packaged-template.json --stack-name templateA --capabilities CAPABILITY_NAMED_IAM 

aws cloudformation package --template FinalProject.json --s3-bucket nlptrainrasgospsicologicos --output-template-file packaged-template.json --use-json

aws cloudformation create-stack --stack-name final-project --template-body file://FinalProject.json --capabilities CAPABILITY_NAMED_IAM

aws cloudformation delete-stack --stack-name final-project

aws cloudformation update-stack --stack-name final-project --template-body file://FinalProject.json --capabilities CAPABILITY_NAMED_IAM