# Build & Push Images To ECR
For this step on the CI proccess i choose to use aws-cli</br>
mainlly cause there is some issue with update repositories with terraform</br>
also for later demonstrate jenkis pipeline there is no need for that if all the code</br>
is written with terraform providers. 

## Bash Script
### 00. Connect Docker With ECR
```bash
account_id=$(aws sts get-caller-identity --query "Account" --output text)
password_stdin="$account_id.dkr.ecr.$region.amazonaws.com"
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $password_stdin
```

### 01. The Function Is Building && Pushing images to ECR Repository.
```bash
build_and_push () {
	echo "Upload to $repo_name"
	path_dockerfile="./images/$1/Dockerfile"
	path_context="./images/$1/"
	tag="$1"
	repo_path="$password_stdin/$repo_name"
	docker build --no-cache -t $repo_name -f $path_dockerfile $path_context
	docker tag "$repo_name" "$repo_path:$tag"
	docker push "$repo_path:$tag"
}
```

### 02. Create Repository If Not Exist, Building & Pushing New Images If Not Exist In Images Folder.
```bash
if [[ $repo_name != $(aws ecr describe-repositories --output text | awk '{print $6}' | grep -w $repo_name) ]];
	then
		# Create Repository.
		echo "Creating Repository $repo_name "
		aws ecr create-repository --repository-name $repo_name
		# Bulid && Push images.
		for image in $(ls -1 images);
		do
			build_and_push $image
		done
	else
		echo "Repository Exist"
		# looking for new images to build && push.
		for image in $(ls -1 images); 
		do
			if [[ $image == $(aws ecr list-images --repository-name $repo_name --output text | awk '{print $3}' | grep -w $image ) ]];
			then
				echo "Image $image exist."
			else
				echo "Image $image not found. Building && Pushing a new image $image."
				build_and_push $image
			fi;
		done
		
fi;
```

## About The Containers
* Tensorflow Image - Will execute image classification model and return request to frontend.
* Ignore nginx & flask images here.
