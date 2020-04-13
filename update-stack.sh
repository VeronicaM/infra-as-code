stack_name=iaac_udacity_mv
config_path=config.yml
params_path=stack_params.json
aws cloudformation update-stack --stack-name $stack_name --template-body file://$config_path  --parameters file://$params_path --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region=us-west-2