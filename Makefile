#########################################################
#                                                       #
# Ladder Operator Vibrational Configuration Interaction #
#                                                       #
#########################################################

### Toolchain + SDK (macOS)
BREW     := $(shell command -v brew 2>/dev/null)
SDKROOT  := $(shell xcrun --sdk macosx --show-sdk-path)
SYSROOT  := -isysroot $(SDKROOT)

### Compiler settings (Homebrew LLVM)
CXX      := /opt/homebrew/opt/llvm/bin/clang++
STD      := -std=c++14

### Include paths
INCS     := -I./src \
            -I$(shell brew --prefix eigen)/include/eigen3 \
            -I$(shell brew --prefix boost)/include \
            -I$(shell brew --prefix spectra)/include \
            -I$(shell brew --prefix libomp)/include

### Compile + link flags
CXXFLAGS := $(STD) -O3 -fopenmp $(SYSROOT) $(INCS)

LDFLAGS  := $(SYSROOT) \
            -L$(shell brew --prefix llvm)/lib \
            -L$(shell brew --prefix libomp)/lib

LDLIBS   := -lomp

#########################################################

### Compile rules for users and devs

install:	title vhcibin manual compdone

clean:		title delbin compdone

#########################################################

### Rules for building various parts of the code

vhcibin:
	@echo ""
	@echo "### Compiling the VHCI binary ###"
	$(CXX) $(CXXFLAGS) ./src/VHCI.cpp -o vhci $(LDFLAGS) $(LDLIBS)

manual:
	@echo ""
	@echo "### Creating the manual ###"
	cp README.md doc/VHCI_manual.txt
	@echo " [Complete]"

compdone:
	@echo ""
	@echo "Done."
	@echo ""

title:
	@echo ""
	@echo "#########################################################"
	@echo "#                                                       #"
	@echo "#    Vibrational Heat-Bath Configuration Interaction    #"
	@echo "#                                                       #"
	@echo "#########################################################"
	@echo ""

delbin:
	@echo ""
	@echo '     ___'
	@echo '    |_  |'
	@echo '      \ \'
	@echo '      |\ \'
	@echo '      | \ \'
	@echo '      \  \ \'
	@echo '       \  \ \'
	@echo '        \  \ \       <wrrr vroooom wrrr> '
	@echo '         \__\ \________'
	@echo '             |_________\'
	@echo '             |__________|  ..,  ,.,. .,.,, ,..'
	@echo ""
	@echo ""
	@echo "Removing binaries and manual..."
	rm -f ./vhci doc/VHCI_manual.txt