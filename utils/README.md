# Unforgettable Fixes

---
### Problem: Terminator double write

Need to modify the terminator source code to fix the double write issue. The issue is that terminator writes the same command twice in the terminal. This is because of the dbus session bus address. The issue is discussed in detail [here](https://askubuntu.com/questions/1189243/why-is-terminator-sending-double-characters-to-terminals-that-arent-selected-in).

```bash
sudo nano /usr/bin/terminator
```

Soon after imports, I set the variable DBUS_SESSION_BUS_ADDRESS to '' (null string), and everything is working perfectly fine for me:


```python
os.environ['DBUS_SESSION_BUS_ADDRESS']=''
```
---