# Assessment
This is a assessment of terraform, ansible and python related tasks

# Having any linux based distribution like ubuntu, AWS account terraform installed, ansible installed aws account config
```
To clone the repository use the below command
git clone https://github.com/Hamza123Khan/Assessment.git
```
# There are some changes to be done in terraform and ansible files like ip, sshkeys

```
run ssh-keygen to generate sshkeys and copy them to terraform files where names are assesment, assessment.pub
change the ip address of security group inbound rule of ec2 instance to you own ip address
```
#I am asumming that terrraform and asnible is installed so go to terraform folder and then these commands
#running terraform for infrastructure creation
```
terraform init // to check the code
terraform plan // to plan the number of services to be created
terraform fmt // to format the terraform files
terraform validate // that the infrastructure is valid
terraform apply // to actually built the infrastructure 
after the infrastructure is completed the you are prompted with 2 ec2 instance ip addr which are public and private copy both of them

```

#running ansible for infrastructure configuration

```
copy the private ip of ec2 and paste it in hosts.ini files in ansible folder
then make sure that your private key location is there in the hosts.ini
run the below command to configure the ec2 instance 
ansible-playbook -i hosts.ini nginx_playbook.yaml 
```

#running python application locally

```
go to python application which is built on fastpi
go to that application folder
create virtual enviornment using pip -m venv venv
go to that folder then apply these command
/venv/Scripts/activate.bat
run pip install -r requirement.txt
configure enviornment variables of mysql_db
run the command using
uvicorn main:app --reload

```
#to configure the application to run on ec2 and points the db to rds mysql use below instructions

```
use scp command to move the
also use chmod 600 assessment to make it executable
scp -i assessmentkeylocation -r /path/to/your_fastapi_app-path-locally ec2-user@your_ec2_public_ip:/home/ec2-user/location_where_you_want_your_application
also can use git clone command to copy the application
create env pip -m venv venv
activate venv
pip install -r requirement.txt
update .env database variables according to your needs
run 
uvicorn main:app --host 0.0.0.0 --port 80
sudo vi /etc/nginx/nginx.conf
update the location to below
location / {
    proxy_pass http://127.0.0.1:8000;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
}

run
sudo systemctl enable nginx
sudo systemctl restart nginx

```

