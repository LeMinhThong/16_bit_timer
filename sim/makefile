TESTNAME ?=
SEED ?= random
COMPARG ?=

#------------------------

all:  clean build run

build:
	mkdir -p log
	vlib work
	vlog -f compile.f +define+${COMPARG}
run:
	vsim -l ${TESTNAME}.log work.${TESTNAME} -do "run -all;exit" -sv_seed ${SEED}
	mv ${TESTNAME}.log ./log
clean:
	rm -rf *.log
	rm -rf log
	rm -rf work
	rm -rf transcript
	rm -rf vsim.wlf

