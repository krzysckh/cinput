WIN_PY=~/.wine/drive_c/users/kpm/AppData/Local/Programs/Python/Python38-32/python.exe
WIN_PYINSTALLER=~/.wine/drive_c/users/kpm/AppData/Local/Programs/Python/Python38-32/Scripts/pyinstaller.exe

PIFLAGS=-F -w --collect-data sv_ttk --collect-data cyrtranslit --collect-data pyclip

.PHONY: all build wine-install-deps wine-run pubcpy clean

all: dist/kacapy.exe
build: all
wine-install-deps:
	wine $(WIN_PY) -m pip install -r requirements.txt
wine-run:
	wine $(WIN_PY) kaca.py
dist/kacapy.exe: wine-install-deps
	wine $(WIN_PYINSTALLER) $(PIFLAGS) -n kacapy ./kaca.py
pubcpy: build
	[ `whoami` = 'kpm' ] || exit 1
	cd dist && yes | pubcpy kacapy.exe
clean:
	rm -fr build dist kacapy.spec
