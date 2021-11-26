run: main.lua
	love .

main.lua: main.sy res/*.sy src/*.sy | sylt
	rm -rf main.lua
	../target/debug/sylt -c $@ $<

sylt:
	cd .. && cargo b

