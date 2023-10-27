KEY_DIR="./keys"

if [ ! -d "$KEY_DIR" ]; then
  ssh-keygen -C "ansible" -t ed25519 -f ./keys/vmkey 
fi
export GOOGLE_APPLICATION_CREDENTIALS=service-account-terraform.json