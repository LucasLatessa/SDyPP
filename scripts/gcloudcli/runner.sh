# PASO 1 - Logeo en Google Cloud
#gcloud services enable logging.googleapis.com
#gcloud logging read "resource.type=gce_instance AND protoPayload.methodName=beta.compute.instances.insert"

# Asociar la region 
#gcloud compute addresses create instance-public-ip --region=us-east1

# Creacion de las reglas de firewall para permitir el trafico en el puerto 80 y 20. Se agrego una regla extra para el
# 8080, permitiendo asi la aplicacion de Node
# gcloud compute firewall-rules create allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0
# gcloud compute firewall-rules create allow-ssh --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:22 --source-ranges=0.0.0.0/0
#  gcloud compute firewall-rules create appnode --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8080 --source-ranges=0.0.0.0/0

# PASO 2 - Creacion de la VM 
gcloud compute instances create vm1     --machine-type=e2-micro     --preemptible     --image-family=ubuntu-2204-lts     --image-project=ubuntu-os-cloud     --tags=http-server     --metadata="ssh-keys=$(cat ./id_rsa_example.pub)"     --metadata-from-file user-data=../userdata/script.sh     --zone="us-east1-b"     --address=instance-public-ip

# PASO 3 - Conexion SSH a la instancia VM1 de GCloud 
gcloud compute ssh vm1 --zone=us-east1-b --ssh-key-file=./id_rsa_example
#gcloud compute ssh vm1 --zone=us-east1-b --ssh-key-file=./id_rsa_example --command "cat /var/log/cloud-init-output.log"

# Comando para eliminar la maquina
# gcloud compute instances delete vm1 --zone=us-east1-b

# Comando para apagar la maquina
#gcloud compute instances stop mv1 --zone=us-east1-b

# Comando para prender la maquina
# gcloud compute instances start vm1 --zone=us-east1-b


