# RISC-V Playground from Scratch

This repo provides a set of Dockerfiles that allows users to easily construct a software development environment of RISC-V architecture.  Technically, the only dependency of this repo is Docker.

One is expected to learn Docker before she try to apply the tools in this repo.  At least, one should setup a Docker environment, and then she can simply follow the steps in the [Usage](#usage) section.

Comments, suggestions, critics, and PRs are welcomed.

## <a name=usage></a> Usage

The core of the script is `Makefile`.  Feel free to modify the variables on the top, especially `IMAGE` and container subnet settings.

### Must
```
$ make bootstrap 	
```
This generates a bootstrap image, which is not expected to be run, but just clone some repos and initial compilations.  It takes hours to days depending on your network speed and storage quality, and occupies about 16G.

```
$ make update
```
This generates a basic image that is ready to be run.  Still, it may take a long period of time, and the final images occupies 20+G space.  You may always apply this command to sync the whole environment to the setting of [freedom-u-sdk repo](https://github.com/sifive/freedom-u-sdk).

### Optional
```
$ make private
```
You may reference and tweak the `Dockerfile.private` file to construct your working space.  The current one is an example of my setting.

Note: Run this command for only **ONCE**.

### Quick Simulation
```
$ make sim
```
Once you have a ready image, you can run this command which launches **spike** to run a RISC-V/Linux system with Busybox installed.

### VM-like Usage
```
$ make run
```
You may **assume** that this command start a **RISC-V/Linux Virtual Machine**.  Do `make ssh` to have other connections to the VM in new terminals.  Once you have done some changes to the environment, you can apply `make commit` to save the status; or `make off` to turn off the VM without saving any changes.

In this VM, you have a set of toolchains in `/home/riscv/bin`, and related source trees in `/` directory.

Note that `make run` multiple times is not allowed.

## References

This repo provides almost no original contents but merely convenient scripts.  For further learning, you might find the following links helps:

* [Docker Playground](https://www.katacoda.com/courses/docker/playground)
* [RISC-V 101](https://info.sifive.com/risc-v-webinar)
* [RISC-V tools](https://github.com/riscv/riscv-tools)
  * spike: the instruction-level simulator 
  * gnu-toolchain: the cross-compiler and binary utilities
  * bbl: the bootloader for RISC-V Supervisors
