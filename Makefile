#hello: hello.c
#gcc hello.c -o hello
## Makefile to copy files to two different locations
## Source directory
#SRC_DIR = ./R
## Destination directories
#DEST_DIR1 = MD_WASMS/examples/r/MD-sandbox/
#DEST_DIR2 = MD_WASMC/packages/
## List of files to copy
#FILES = simulations.R
## Targets
##all: copy_to_dest1 copy_to_dest2
#abc:
#@echo "Hello world!"
#@echo "Copying files to $(DEST_DIR1)..."
###@cp $(addprefix $(SRC_DIR)/, $(FILES)) $(DEST_DIR1)
##copy_to_dest2:
##@echo "Copying files to $(DEST_DIR2)..."
###@cp $(addprefix $(SRC_DIR)/, $(FILES)) $(DEST_DIR2)
##clean:
##@echo "Cleaning up..."
###@rm -rf $(DEST_DIR1) $(DEST_DIR2)
##.PHONY: all copy_to_dest1 copy_to_dest2 clean
