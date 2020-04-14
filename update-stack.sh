stack_name=iaac-udacity-mv
config_path=file://config.yml
params_path=file://stack-params.json
aws cloudformation update-stack --stack-name $stack_name --template-body $config_path  --parameters $params_path --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region=us-west-2