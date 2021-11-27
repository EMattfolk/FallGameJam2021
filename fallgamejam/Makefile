run: main.lua
	love .

main.lua: main.sy *.sy res/*.sy src/*.sy | sylt
	rm -rf main.lua
	../target/debug/sylt -c $@ $< || rm $@

sylt:
	cd .. && cargo b

