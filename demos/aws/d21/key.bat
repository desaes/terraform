del mykeypair mykeypair.pub
ssh-keygen -t rsa -m pem -f mykeypair
icacls mykeypair /inheritance:r
icacls mykeypair /grant:r "%username%":"(R)"