del mykey mykey.pub
ssh-keygen -t rsa -m pem -f mykey
icacls mykey /inheritance:r
icacls mykey /grant:r "%username%":"(R)"