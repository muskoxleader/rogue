BIN_DIR      = /usr/local/bin
ROOT_DIR     = $$HOME/.rogue
CONFIG_FILE  = $(ROOT_DIR)/.config
TEMPLATE_DIR = $(ROOT_DIR)/.templates

install:: root config templates bin

bin::
	@cp rogue $(BIN_DIR); \
		echo "OK: $(BIN_DIR)/rogue"

config::
	@[ ! -f $(CONFIG_FILE) ] && touch $(CONFIG_FILE); \
		echo "OK: $(CONFIG_FILE)"

root::
	@[ ! -d $(ROOT_DIR) ] && mkdir $(ROOT_DIR); \
		echo "OK: $(ROOT_DIR)"

templates::
	@[ ! -d $(TEMPLATE_DIR) ] && mkdir $(TEMPLATE_DIR); \
		echo "OK: $(TEMPLATE_DIR)"
