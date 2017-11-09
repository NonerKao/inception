
.nstPHONY: bootstrap update private sim run off

IMAGE := qlkao/archrv
TAG := $(shell date +%Y%m%d"_"%H%M)
SUBNET := 172.20.18.0/24
IPADDR := 172.20.18.99


all: update

bootstrap: Dockerfile.bootstrap inittab linux.config busybox.config initramfs.txt mirrorlist
	docker build -f Dockerfile.bootstrap --no-cache -t $(IMAGE):boot .
	docker tag $(IMAGE):boot $(IMAGE):latest

update: Dockerfile.update
	docker build -f Dockerfile.update --no-cache -t $(IMAGE):$(TAG) .
	docker tag $(IMAGE):$(TAG) $(IMAGE):latest

#private: 
#	docker build -f Dockerfile.private --no-cache -t $(IMAGE):latest .

sim:
	docker run --rm -it $(IMAGE):latest /home/riscv/bin/spike /home/riscv/riscv64-unknown-elf/bin/bbl

run:
	docker network create --subnet=$(SUBNET) ITIRONMAN 2>&1 >/dev/null
	docker run --net ITIRONMAN --ip $(IPADDR) -d $(IMAGE):latest /usr/sbin/sshd -D 2>&1 >/dev/null
	sleep 1
	ssh root@$(IPADDR)

commit:
	ssh root@$(IPADDR) make -C / clean
	docker commit $(shell docker ps -aq) $(IMAGE):$(TAG)
	docker tag $(IMAGE):$(TAG) $(IMAGE):latest

off:
	docker rm --force $(shell docker ps -aq) 2>&1 >/dev/null
	docker network remove ITIRONMAN 2>&1 >/dev/null
	@echo "The container is removed."
