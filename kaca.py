#!/usr/bin/env python3
# -*- mode: python; python-indent-offset: 2 -*-

import typing
import cyrtranslit
import tkinter
import sv_ttk
import pyclip
import sys
import os
import time

from tkinter import ttk

root: tkinter.Tk
winsize = None
cyrylic_sv: tkinter.StringVar

def clipcpy(s):
  if os.name == 'nt':
    pyclip.copy(s)
  else:
    print(s)
    os.system(f"sh -c 'echo \"{s}\" | xclip -sel c -rmlastnl'")

def mp_handler():
  global root, winsize

  if winsize == None:
    winsize = [root.winfo_width(), root.winfo_height()]

  x = root.winfo_pointerx()
  y = root.winfo_pointery()
  root.geometry(f"+{x}+{y}")
  root.lift()
  root.after(10, mp_handler)

def text_handler(sv):
  cyrylic_sv.set(cyrtranslit.to_cyrillic(sv.get(), 'ru'))

def exit_handler(ev):
  if ev.keysym == 'Return' or ev.keysym == 'Escape':
    clipcpy(cyrylic_sv.get())
    sys.exit(0)

def main():
  global root, cyrylic_sv

  root = tkinter.Tk()
  sv = tkinter.StringVar()
  cyrylic_sv = tkinter.StringVar()

  root.title("kaca.py")
  root.resizable(width=False, height=False)

  inp = ttk.Entry(master=root, textvariable=sv)
  inp.pack(fill="both", expand=False, padx=5, pady=5)
  inp.focus_set()

  out = ttk.Entry(master=root, textvariable=cyrylic_sv)
  out.pack(fill="both", expand=False, padx=5, pady=5)

  sv_ttk.set_theme("light")

  sv.trace("w", lambda name, index, mode, sv=sv: text_handler(sv))

  mp_handler()
  root.bind("<KeyRelease>", exit_handler)
  root.mainloop()

if __name__ == "__main__":
  main()
