NAME=mosfet

all: sim

magic:
	# for rcfile to work PDK_ROOT must be set correctly
	magic -rcfile $(PDK_ROOT)/$(PDK)/libs.tech/magic/$(PDK).magicrc $(NAME).mag
	# now in the command window type:
	# extract
	# ext2spice lvs
	# ext2spice cthresh 0
	# ext2spice

simulation.spice: pre.spice $(NAME).spice post.spice
    # magic puts subckt and end around extract, so remove it
	sed -i -e 's/.ends//' $(NAME).spice
	sed -i -e 's/.subckt mosfet//' $(NAME).spice
	# build a simulation with pre and post.spice
	cat $^ > $@

sim: simulation.spice
	# run the simulation
	ngspice $^

clean:
	rm -f $(NAME).spice model.spice $(NAME).ext

phony: clean
