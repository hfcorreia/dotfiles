#!/bin/zsh

# AWS CLI Helper Functions with fzf Integration
function aws_whoami() {
  local option="${1:-}"
  local PROFILE="${AWS_PROFILE:-default}"

  if [[ "$option" == "--profile-no-color" ]]; then
    echo "$PROFILE"
    return 0
  fi

  if [[ "$option" == "--profile" ]]; then
    echo -e "\033[93m$PROFILE\033[0m"
    return 0
  fi

  local arn
  arn=$(aws sts get-caller-identity 2>/dev/null | jq -r .Arn)

  if [[ -z "$arn" ]]; then
    echo -e "[\033[93m$PROFILE\033[0m] Not logged in."
    return 1
  fi

  if [[ "$arn" == *"assumed-role/"* ]]; then
    local role=$(echo "$arn" | cut -d/ -f2)
    local user=$(echo "$arn" | cut -d/ -f3)
    echo -e "[\033[93m$PROFILE\033[0m] ADFS: \033[36m$user\033[0m as role \033[31m$role\033[0m"
  else
    local user=$(echo "$arn" | cut -d/ -f2)
    echo -e "[\033[93m$PROFILE\033[0m] IAM: \033[31m$user\033[0m"
  fi

  return 0
}

# Check AWS CLI login status and allow profile selection using fzf
function aws_check_login() {
  aws sts get-caller-identity > /dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    aws_whoami
    return 0
  fi

  # Gather profiles from config and credentials files
  local profiles=()
  if [[ -f ~/.aws/config ]]; then
    profiles+=($(grep '^\[profile ' ~/.aws/config | sed 's/^\[profile \(.*\)\]/\1/'))
  fi
  if [[ -f ~/.aws/credentials ]]; then
    profiles+=($(grep '^\[' ~/.aws/credentials | sed 's/^\[\(.*\)\]/\1/'))
  fi
  # Remove duplicates
  profiles=($(printf "%s\n" "${profiles[@]}" | sort -u))

  if [[ ${#profiles[@]} -eq 0 ]]; then
    echo "No AWS profiles found."
    return 1
  fi

  local selected_profile=$(printf "%s\n" "${profiles[@]}" | fzf --prompt="Select AWS Profile to login: " --print-query | xargs)
  echo "Selected profile: $selected_profile"
  if [[ -z "$selected_profile" ]]; then
    echo "No profile selected."
    return 1
  fi

  if ! printf "%s\n" "${profiles[@]}" | grep -qx "$selected_profile"; then
    echo "Profile '$selected_profile' does not exist. Logging in with new profile."
    iam-login "$selected_profile" # depends on iam-login function in global environment
  fi

  export AWS_PROFILE="$selected_profile"
  aws_whoami
}

# Select an ECS cluster using fzf
function aws_get_ecs_cluster() {
  aws ecs list-clusters --query "clusterArns[]" --output text | tr '\t' '\n' | fzf --prompt="Select ECS Cluster: "
}

# Select an ECS service from a cluster using fzf
function aws_get_ecs_service() {
  if [[ -z "$1" ]]; then
    echo "Usage: aws_select_service <cluster_name>"
    return 1
  fi

  local cluster="$1"
  aws ecs list-services --cluster "$cluster" --query "serviceArns[]" --output text | tr '\t' '\n' | fzf --prompt="Select ECS Service: "
}

# Select an ECS task from a cluster and service using fzf
function aws_ecs_get_task() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: aws_select_task <cluster_name> <service_name>"
    return 1
  fi

  local cluster="$1"
  local service="$2"
  aws ecs list-tasks --cluster "$cluster" --service-name "$service" --query "taskArns[]" --output text | tr '\t' '\n' | fzf --prompt="Select ECS Task: "
}

# Start an SSM session to an ECS task
function aws_ssm_session() {
  local mode="${1:-ec2}" # default to machine if not specified

  aws_check_login || return 1

  local cluster=$(aws_get_ecs_cluster)
  [[ -z "$cluster" ]] && echo "No cluster selected." && return 1

  local service=$(aws_get_ecs_service "$cluster")
  [[ -z "$service" ]] && echo "No service selected." && return 1

  local task=$(aws_ecs_get_task "$cluster" "$service")
  [[ -z "$task" ]] && echo "No task selected." && return 1

  # Describe the ECS task once
  local task_json=$(aws ecs describe-tasks --cluster "$cluster" --tasks "$task")
  local container_instance_arn=$(echo "$task_json" | jq -r '.tasks[0].containerInstanceArn')
  local runtime_id=$(echo "$task_json" | jq -r '.tasks[0].containers[0].runtimeId')

  if [[ "$container_instance_arn" == "null" || -z "$container_instance_arn" ]]; then
    echo "Could not find container instance for the selected task."
    return 1
  fi

  local instance_id=$(aws ecs describe-container-instances --cluster "$cluster" --container-instances "$container_instance_arn" \
    --query "containerInstances[0].ec2InstanceId" --output text)
  if [[ "$instance_id" == "None" || -z "$instance_id" ]]; then
    echo "Could not find EC2 instance ID for the selected container instance."
    return 1
  fi

  echo -e "Selected Cluster: $cluster\nService: $service\nTask: $task\nInstance ID: $instance_id"

  if [[ "$mode" == "ec2" ]]; then
    echo "Starting SSM session to the EC2 instance..."
    aws ssm start-session --target "$instance_id" --document-name AWS-StartInteractiveCommand --parameters command="bash -l"
  elif [[ "$mode" == "ecs" ]]; then
    if [[ "$runtime_id" == "null" || -z "$runtime_id" ]]; then
      echo "Could not find Docker runtime ID for the selected ECS task."
      return 1
    fi

    echo "Starting SSM session to the container running ECS task..."
    aws ssm start-session --target "$instance_id" --document-name AWS-StartInteractiveCommand --parameters command="sudo docker container exec -it $runtime_id /bin/sh"
  fi

  return 0
}

