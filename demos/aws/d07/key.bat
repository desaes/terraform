del mykey mykey.pub
ssh-keygen -t rsa -m pem -f ssh-key
icacls ssh-key /inheritance:r
icacls ssh-key /grant:r "%username%":"(R)"