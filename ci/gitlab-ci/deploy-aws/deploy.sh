#!bin/bash
export TASK_DEFINITION_ARN=$(aws ecs register-task-definition --family TestTaskDefinition --region $AWS_REGION --cli-input-json file://deploy.json | jq '.taskDefinition.taskDefinitionArn' --raw-output)
aws ecs update-service --cluster testCluster --service testService --task-definition ${TASK_DEFINITION_ARN} --region $AWS_REGION
