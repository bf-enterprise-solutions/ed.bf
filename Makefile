.PHONY: run all

bfed.bf: bfed.m4 bfed.in
	m4 $^ >> bfed.bf

all: bfed.bf

run: bfed.bf
	${BF} $^
