WIN_PY=~/.wine/drive_c/users/kpm/AppData/Local/Programs/Python/Python38-32/python.exe
WIN_PYINSTALLER=~/.wine/drive_c/users/kpm/AppData/Local/Programs/Python/Python38-32/Scripts/pyinstaller.exe

PIFLAGS=-F -w --collect-data sv_ttk --collect-data cyrtranslit --collect-data pyclip

.PHONY: all build wine-install-deps wine-run pubcpy clean

all: dist/cinput.exe
build: all
wine-install-deps:
	wine $(WIN_PY) -m pip install -r requirements.txt
wine-run:
	wine $(WIN_PY) cinput.py
dist/cinput.exe: wine-install-deps
	wine $(WIN_PYINSTALLER) $(PIFLAGS) ./cinput.py
pubcpy:
	[ `whoami` = 'kpm' ] || exit 1
	cd dist && yes | pubcpy cinput.exe
clean:
	rm -fr build dist cinput.spec
